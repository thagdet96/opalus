import 'package:flutter/material.dart';
import 'package:opalus/src/blocs/transactionNavBar/transactionNavBarBloc.dart';
import 'package:opalus/src/blocs/transactionNavBar/transactionNavBarState.dart';
import 'package:opalus/src/models/reponse/groupTransactions.dart';
import 'package:opalus/src/services/transaction.dart';
import 'package:opalus/src/views/components/transaction/byDate/transactionsPerDate.dart';

class DateScreen extends StatefulWidget {
  @override
  DateScreenState createState() => DateScreenState();
}

class DateScreenState extends State<DateScreen>
    with AutomaticKeepAliveClientMixin<DateScreen> {
  List<GroupTransaction> listTransactions = [];

  final _bloc = TransactionNavBarBloc();

  @override
  bool get wantKeepAlive => true;

  @override
  initState() {
    super.initState();
    getListTransactionGroupByDate();
  }

  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  getListTransactionGroupByDate() async {
    var fetched = await TransactionService().getAndGroupByDate(
      DateTime.now(),
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
        builder: (BuildContext context,
            AsyncSnapshot<TransactionNavBarState> snapshot) {
          TransactionNavBarState state = snapshot.data ?? _bloc.navBarState;
          DateTime selectedDate = state.selectedDate;
          print(selectedDate);

          return ListView.builder(
              itemCount: listTransactions.length,
              itemBuilder: (context, index) {
                return TransactionsPerDate(listTransactions[index]);
              });
        });
  }
}
