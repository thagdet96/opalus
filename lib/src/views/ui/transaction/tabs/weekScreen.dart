import 'package:flutter/material.dart';
import 'package:opalus/src/models/reponse/groupTransactions.dart';
import 'package:opalus/src/services/transaction.dart';
import 'package:opalus/src/utils/constants.dart';
import 'package:opalus/src/utils/formats.dart';
import 'package:opalus/src/utils/myTheme.dart';
import 'package:opalus/src/views/components/transaction/byWeek/summarizedTopItem.dart';
import 'package:opalus/src/views/components/transaction/byWeek/weekRow.dart';

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(64),
        child: Card(
          child: Row(
            children: [
              SummariedTopItem(
                title: 'Income',
                amount: convertToCurrency(
                  totalIncome,
                  style: MyTheme.bigCurrency(context, TRANSACTION_TYPE.INCOME),
                ),
              ),
              SummariedTopItem(
                title: 'Outcome',
                amount: convertToCurrency(
                  totalOutcome,
                  style: MyTheme.bigCurrency(context, TRANSACTION_TYPE.OUTCOME),
                ),
              ),
              SummariedTopItem(
                title: 'Total',
                amount: convertToCurrency(
                  totalIncome - totalOutcome,
                  style: MyTheme.bigCurrency(context),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView.separated(
        itemCount: totalByWeeks.length,
        itemBuilder: (context, index) {
          return WeekRow(totalByWeeks[index]);
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }
}
