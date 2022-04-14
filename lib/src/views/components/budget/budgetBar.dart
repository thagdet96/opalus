import 'package:flutter/material.dart';
import 'package:opalus/src/utils/constants.dart';
import 'package:opalus/src/utils/formats.dart';
import 'package:opalus/src/utils/myTheme.dart';
import 'package:opalus/src/views/components/transaction/byGroup/summarizedTopItem.dart';

class BudgetBar extends StatelessWidget implements PreferredSizeWidget {
  final int budget;
  final int amount;
  Size get preferredSize => const Size.fromHeight(64);

  BudgetBar({required this.budget, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          SummarizedTopItem(
            title: CONSTANT_TEXT.BUDGET,
            amount: convertToCurrency(
              budget,
              style: MyTheme.bigCurrency(context),
            ),
          ),
          SummarizedTopItem(
            title: CONSTANT_TEXT.AMOUNT,
            amount: convertToCurrency(
              amount,
              style: MyTheme.bigCurrency(
                context,
                amount > budget
                    ? TRANSACTION_TYPE.OUTCOME
                    : TRANSACTION_TYPE.INCOME,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
