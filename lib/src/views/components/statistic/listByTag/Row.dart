import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:opalus/src/models/index.dart';
import 'package:opalus/src/models/response/groupTransactionsByTag.dart';
import 'package:opalus/src/utils/formats.dart';
import 'package:opalus/src/utils/myTheme.dart';

class RowTransactionsByTag extends StatelessWidget {
  final GroupTransactionByTag transactionsByTag;

  RowTransactionsByTag(this.transactionsByTag);

  @override
  Widget build(BuildContext context) {
    List<Transaction> transactions = transactionsByTag.transactions ?? [];

    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Badge(
            toAnimate: false,
            borderRadius: BorderRadius.circular(8),
            padding: EdgeInsets.all(6),
            shape: BadgeShape.square,
            badgeColor: MyTheme.accentColor(),
            badgeContent: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 48),
              child: getName(transactionsByTag.tag, style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: transactions.where((t) => t.title != null && t.title!.isNotEmpty).map(getName).toList(),
          ),
        ),
        Container(
          width: 100,
          child: convertToCurrency(
            transactionsByTag.amount,
            style: MyTheme.regularCurrency(context, transactionsByTag.type),
          ),
        ),
      ],
    );
  }
}
