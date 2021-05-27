import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:opalus/src/utils/constants.dart';
import 'package:opalus/src/utils/formats.dart';
import 'package:opalus/src/utils/myTheme.dart';

class GroupRow extends StatelessWidget {
  final String badgeContent;
  final int income;
  final int outcome;
  GroupRow({
    required this.badgeContent,
    required this.income,
    required this.outcome,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity(vertical: -4),
      leading: Badge(
        toAnimate: false,
        borderRadius: BorderRadius.circular(8),
        padding: EdgeInsets.all(6),
        shape: BadgeShape.square,
        badgeColor: MyTheme.accentColor(),
        badgeContent: ConstrainedBox(
          constraints: BoxConstraints(minWidth: 48),
          child: Text(
            badgeContent,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
      title: convertToCurrency(
        income,
        style: MyTheme.regularCurrency(context, TRANSACTION_TYPE.INCOME),
      ),
      trailing: convertToCurrency(
        outcome,
        style: MyTheme.regularCurrency(context, TRANSACTION_TYPE.OUTCOME),
      ),
    );
  }
}
