import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opalus/src/models/index.dart';
import 'package:opalus/src/utils/formats.dart';
import './transactionRow.dart';

class TransactionsInDate extends StatelessWidget {
  final TransactionsGroupByDate transactionsGroup;

  TransactionsInDate(this.transactionsGroup);

  @override
  Widget build(BuildContext context) {
    List<Transaction> transactions = transactionsGroup.transactions;
    DateTime date = transactionsGroup.date;

    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(8, 0, 16, 0),
            leading: Container(
              alignment: Alignment.centerLeft,
              width: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Badge(
                    borderRadius: BorderRadius.circular(8),
                    shape: BadgeShape.square,
                    badgeColor: Colors.blue,
                    badgeContent: Text(
                      DateFormat('EE').format(date),
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('dd').format(date),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(DateFormat('M-yy').format(date))
                    ],
                  )
                ],
              ),
            ),
            title: convertToCurrency(
              transactionsGroup.income,
              style: TextStyle(color: Colors.green, fontSize: 14),
            ),
            trailing: convertToCurrency(
              transactionsGroup.outcome,
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
          ),
          Divider(color: Colors.grey, height: 0),
          ...transactions.map((t) => TransactionRow(t))
        ],
      ),
    );
  }
}
