import 'package:flutter/material.dart';
import 'package:opalus/src/models/response/groupTransactions.dart';
import 'package:opalus/src/services/transaction.dart';
import 'package:opalus/src/utils/formats.dart';
import 'package:opalus/src/views/components/transaction/byGroup/index.dart';

class WeekScreen extends StatefulWidget {
  @override
  WeekScreenState createState() => WeekScreenState();
}

class WeekScreenState extends State<WeekScreen> {
  List<GroupTransaction> totalByWeeks = [];

  @override
  initState() {
    super.initState();
    getListTransactionGroupByWeek();
  }

  getListTransactionGroupByWeek() async {
    var fetched = await TransactionService().getAndGroupByWeek(
      DateTime.now(),
    );
    setState(() {
      totalByWeeks = fetched;
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalIncome = totalByWeeks.fold(0, (cur, e) => cur + e.income);
    int totalOutcome = totalByWeeks.fold(0, (cur, e) => cur + e.outcome);

    return Scaffold(
      appBar: TopBar(totalIncome: totalIncome, totalOutcome: totalOutcome),
      body: ListView.separated(
        itemCount: totalByWeeks.length,
        itemBuilder: (context, index) {
          String badgeContent = getRange(
            startDate: totalByWeeks[index].time,
            endDate: totalByWeeks[index].time.add(Duration(days: 6)),
          );
          return GroupRow(
            badgeContent: badgeContent,
            income: totalByWeeks[index].income,
            outcome: totalByWeeks[index].outcome,
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }
}
