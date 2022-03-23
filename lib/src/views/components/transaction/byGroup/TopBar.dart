import 'package:flutter/material.dart';
import 'package:opalus/src/utils/constants.dart';
import 'package:opalus/src/utils/formats.dart';
import 'package:opalus/src/utils/myTheme.dart';
import './summarizedTopItem.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final int totalIncome;
  final int totalOutcome;
  Size get preferredSize => const Size.fromHeight(64);

  TopBar({required this.totalIncome, required this.totalOutcome});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          SummarizedTopItem(
            title: CONSTANT_TEXT.INCOME,
            amount: convertToCurrency(
              totalIncome,
              style: MyTheme.bigCurrency(context, TRANSACTION_TYPE.INCOME),
            ),
          ),
          SummarizedTopItem(
            title: CONSTANT_TEXT.OUTCOME,
            amount: convertToCurrency(
              totalOutcome,
              style: MyTheme.bigCurrency(context, TRANSACTION_TYPE.OUTCOME),
            ),
          ),
          SummarizedTopItem(
            title: CONSTANT_TEXT.TOTAL,
            amount: convertToCurrency(
              totalIncome - totalOutcome,
              style: MyTheme.bigCurrency(context),
            ),
          ),
        ],
      ),
    );
  }
}
