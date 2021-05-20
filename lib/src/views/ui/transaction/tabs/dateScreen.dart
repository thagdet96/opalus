import 'package:flutter/material.dart';
import 'package:opalus/src/mocks/transaction.dart';
import 'package:opalus/src/models/index.dart';
import 'package:opalus/src/views/components/transaction/byDate/transactionsPerDate.dart';

class DateScreen extends StatelessWidget {
  final listTransactions = [
    TransactionsGroupByDate(
      date: DateTime(2021, 5, 5),
      income: 10000000,
      outcome: 300000,
      transactions: [mockTransactions[0], mockTransactions[1]],
    ),
    TransactionsGroupByDate(
      date: DateTime(2021, 5, 6),
      income: 0,
      outcome: 50000,
      transactions: [mockTransactions[2]],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listTransactions.length,
        itemBuilder: (context, index) {
          return TransactionsPerDate(listTransactions[index]);
        });
  }
}
