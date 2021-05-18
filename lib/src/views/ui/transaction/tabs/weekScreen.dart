import 'package:flutter/material.dart';
import 'package:opalus/src/models/reponse/transactionsGroupByWeek.dart';
import 'package:opalus/src/utils/constants.dart';
import 'package:opalus/src/utils/formats.dart';
import 'package:opalus/src/utils/myTheme.dart';
import 'package:opalus/src/views/components/transaction/byWeek/summarizedTopItem.dart';
import 'package:opalus/src/views/components/transaction/byWeek/weekRow.dart';

class WeekScreen extends StatelessWidget {
  final totalByWeeks = [
    TransactionsGroupByWeek(
      startDate: DateTime(2021, 5, 5),
      endDate: DateTime(2021, 5, 11),
      income: 10000000,
      outcome: 300000,
    ),
    TransactionsGroupByWeek(
      startDate: DateTime(2021, 5, 12),
      endDate: DateTime(2021, 5, 18),
      income: 0,
      outcome: 50000,
    ),
    TransactionsGroupByWeek(
      startDate: DateTime(2021, 5, 19),
      endDate: DateTime(2021, 5, 25),
      income: 300000,
      outcome: 100000,
    ),
    TransactionsGroupByWeek(
      startDate: DateTime(2021, 5, 26),
      endDate: DateTime(2021, 6, 2),
      income: 0,
      outcome: 80000,
    ),
    TransactionsGroupByWeek(
      startDate: DateTime(2021, 6, 2),
      endDate: DateTime(2021, 6, 4),
      income: 0,
      outcome: 90000,
    ),
  ];

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
