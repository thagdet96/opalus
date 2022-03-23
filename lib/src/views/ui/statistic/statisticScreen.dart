import 'package:flutter/material.dart';
import 'package:opalus/src/utils/constants.dart';
import 'package:opalus/src/utils/myTheme.dart';
import 'package:opalus/src/views/components/statistic/listByTag/ListByTag.dart';

class StatisticScreen extends StatefulWidget {
  @override
  StatisticScreenState createState() => StatisticScreenState();
}

class StatisticScreenState extends State<StatisticScreen> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            height: 42,
            color: MyTheme.primaryColor(),
            child: TabBar(
              controller: _controller,
              indicatorColor: MyTheme.secondaryColor(),
              unselectedLabelColor: MyTheme.secondaryColorDark(),
              labelColor: MyTheme.secondaryColor(),
              tabs: [
                Tab(
                  text: CONSTANT_TEXT.OUTCOME,
                ),
                Tab(
                  text: CONSTANT_TEXT.INCOME,
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            ListByTag(TRANSACTION_TYPE.OUTCOME),
            ListByTag(TRANSACTION_TYPE.INCOME),
          ],
        ),
      ),
    );
  }
}
