import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:opalus/src/models/response/summarizeTag.dart';
import 'package:opalus/src/utils/formats.dart';
import 'package:opalus/src/utils/myTheme.dart';

class RowTagBudget extends StatelessWidget {
  final SummarizeTag summarizeTag;

  RowTagBudget(this.summarizeTag);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
              child: getName(summarizeTag.tag,
                  style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ),
        ),
        Expanded(
          child: Container(),
        ),
        Container(
          width: 100,
          child: convertToCurrency(
            summarizeTag.amount,
            // style: MyTheme.regularCurrency(context, transactionsByTag.type),
          ),
        ),
      ],
    );
  }
}
