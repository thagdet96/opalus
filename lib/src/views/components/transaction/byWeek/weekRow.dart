import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:opalus/src/models/reponse/transactionsGroupByWeek.dart';
import 'package:opalus/src/utils/formats.dart';

class WeekRow extends StatelessWidget {
  final TransactionsGroupByWeek week;

  WeekRow(this.week);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity(vertical: -4),
      leading: Badge(
        borderRadius: BorderRadius.circular(8),
        padding: EdgeInsets.all(6),
        shape: BadgeShape.square,
        badgeColor: Colors.blue,
        badgeContent: Text(
          getRange(startDate: week.startDate, endDate: week.endDate),
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
      title: convertToCurrency(
        week.income,
        style: TextStyle(color: Colors.green, fontSize: 14),
      ),
      trailing: convertToCurrency(
        week.outcome,
        style: TextStyle(color: Colors.red, fontSize: 14),
      ),
    );
  }
}
