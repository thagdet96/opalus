import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:opalus/src/models/reponse/groupTransactions.dart';
import 'package:opalus/src/utils/constants.dart';
import 'package:opalus/src/utils/formats.dart';
import 'package:opalus/src/utils/myTheme.dart';

class WeekRow extends StatelessWidget {
  final GroupTransaction week;

  WeekRow(this.week);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity(vertical: -4),
      leading: Badge(
        borderRadius: BorderRadius.circular(8),
        padding: EdgeInsets.all(6),
        shape: BadgeShape.square,
        badgeColor: MyTheme.accentColor(),
        badgeContent: Text(
          getRange(
            startDate: week.time,
            endDate: week.time.add(Duration(days: 6)),
          ),
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
      title: convertToCurrency(
        week.income,
        style: MyTheme.regularCurrency(context, TRANSACTION_TYPE.INCOME),
      ),
      trailing: convertToCurrency(
        week.outcome,
        style: MyTheme.regularCurrency(context, TRANSACTION_TYPE.OUTCOME),
      ),
    );
  }
}
