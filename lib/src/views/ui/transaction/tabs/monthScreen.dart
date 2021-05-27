import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opalus/src/models/reponse/groupTransactions.dart';
import 'package:opalus/src/services/transaction.dart';
import 'package:opalus/src/views/components/transaction/byGroup/index.dart';

class MonthScreen extends StatefulWidget {
  @override
  MonthScreenState createState() => MonthScreenState();
}

class MonthScreenState extends State<MonthScreen> {
  List<GroupTransaction> totalByMonths = [];

  @override
  initState() {
    super.initState();
    getListTransactionGroupByMonth();
  }

  getListTransactionGroupByMonth() async {
    var fetched = await TransactionService().getAndGroupByMonth(
      DateTime.now(),
    );
    setState(() {
      totalByMonths = fetched;
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalIncome = totalByMonths.fold(0, (cur, e) => cur + e.income);
    int totalOutcome = totalByMonths.fold(0, (cur, e) => cur + e.outcome);

    return Scaffold(
      appBar: TopBar(totalIncome: totalIncome, totalOutcome: totalOutcome),
      body: ListView.separated(
        itemCount: totalByMonths.length,
        itemBuilder: (context, i) {
          return GroupRow(
            badgeContent: DateFormat('MMMM').format(totalByMonths[i].time),
            income: totalByMonths[i].income,
            outcome: totalByMonths[i].outcome,
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }
}
