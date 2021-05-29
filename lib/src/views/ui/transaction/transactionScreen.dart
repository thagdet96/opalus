import 'package:flutter/material.dart';
import 'package:opalus/src/blocs/transactionNavBar/transactionNavBarBloc.dart';
import 'package:opalus/src/utils/myTheme.dart';
import 'package:opalus/src/views/ui/transaction/tabs/index.dart';
import 'package:opalus/src/views/components/transaction/addTransactionButton/addTransactionButton.dart';

class TransactionScreen extends StatefulWidget {
  @override
  TransactionScreenState createState() => TransactionScreenState();
}

class TransactionScreenState extends State<TransactionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  final _bloc = TransactionNavBarBloc();

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            height: 42,
            color: MyTheme.primaryColor(),
            child: TabBar(
              indicatorColor: MyTheme.secondaryColor(),
              unselectedLabelColor: MyTheme.secondaryColorDark(),
              labelColor: MyTheme.secondaryColor(),
              tabs: [
                Tab(
                  text: "Calendar",
                ),
                Tab(
                  text: "Day",
                ),
                Tab(
                  text: "Week",
                ),
                Tab(
                  text: "Month",
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            Calendar(_controller),
            DateScreen(),
            WeekScreen(),
            MonthScreen(),
          ],
        ),
        floatingActionButton: AddTransactionButton(),
      ),
    );
  }
}
