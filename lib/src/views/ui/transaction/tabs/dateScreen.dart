import 'package:flutter/material.dart';
import 'package:opalus/src/blocs/transactionNavBar/transactionNavBarBloc.dart';
import 'package:opalus/src/blocs/transactionNavBar/transactionNavBarState.dart';
import 'package:opalus/src/models/response/groupTransactions.dart';
import 'package:opalus/src/services/transaction.dart';
import 'package:opalus/src/views/components/transaction/byDate/transactionsPerDate.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class DateScreen extends StatefulWidget {
  @override
  DateScreenState createState() => DateScreenState();
}

class DateScreenState extends State<DateScreen> with AutomaticKeepAliveClientMixin<DateScreen> {
  List<GroupTransaction> listTransactions = [];
  DateTime selectedDate = DateTime.now();
  final _bloc = TransactionNavBarBloc();
  final scrollDirection = Axis.vertical;
  late AutoScrollController controller;
  @override
  bool get wantKeepAlive => true;

  @override
  initState() {
    super.initState();
    controller = AutoScrollController(
        viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: scrollDirection);
  }

  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  getListTransactionGroupByDate(DateTime selectedDate) async {
    controller.scrollToIndex(selectedDate.day, preferPosition: AutoScrollPosition.begin);
    List<GroupTransaction> fetched = await TransactionService().getAndGroupByDate(
      selectedDate,
      true,
    );
    setState(() {
      listTransactions = fetched;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder(
      stream: _bloc.state,
      initialData: TransactionNavBarState(DateTime.now()),
      builder: (BuildContext context, AsyncSnapshot<TransactionNavBarState> snapshot) {
        if (snapshot.hasData && selectedDate != snapshot.data!.selectedDate) {
          selectedDate = snapshot.data!.selectedDate;
          getListTransactionGroupByDate(selectedDate);
        }
        return ListView(
          scrollDirection: scrollDirection,
          controller: controller,
          children: listTransactions.map((groupTransaction) {
            return AutoScrollTag(
              key: ValueKey(groupTransaction.time.day),
              controller: controller,
              index: groupTransaction.time.day,
              child: TransactionsPerDate(groupTransaction),
              highlightColor: Colors.black.withOpacity(0.1),
            );
          }).toList(),
        );
      },
    );
  }
}
