import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opalus/src/models/index.dart';
import 'package:opalus/src/utils/constants.dart';
import 'package:opalus/src/models/reponse/groupTransactions.dart';
import 'package:opalus/src/utils/formats.dart';
import 'transactionRow.dart';
import 'package:opalus/src/utils/myTheme.dart';

class TransactionsPerDate extends StatelessWidget {
  final GroupTransaction transactionsGroup;

  TransactionsPerDate(this.transactionsGroup);

  @override
  Widget build(BuildContext context) {
    List<Transaction> transactions = transactionsGroup.transactions ?? [];
    DateTime date = transactionsGroup.time;

    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(8, 0, 16, 0),
            leading: Container(
              alignment: Alignment.centerLeft,
              width: 60,
              margin: EdgeInsets.only(right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Badge(
                    toAnimate: false,
                    borderRadius: BorderRadius.circular(8),
                    shape: BadgeShape.square,
                    badgeColor: MyTheme.accentColor(),
                    badgeContent: Text(
                      DateFormat('EE').format(date),
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('dd').format(date),
                        style: TextStyle(
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
              style: MyTheme.bigCurrency(context, TRANSACTION_TYPE.INCOME),
            ),
            trailing: convertToCurrency(
              transactionsGroup.outcome,
              style: MyTheme.bigCurrency(context, TRANSACTION_TYPE.OUTCOME),
            ),
          ),
          Divider(color: Colors.grey, height: 0),
          ...transactions.map((t) => TransactionRow(t))
        ],
      ),
    );
  }
}
