import 'package:flutter/material.dart';
import 'package:opalus/src/utils/constants.dart';
import 'package:opalus/src/utils/formats.dart';
import 'package:opalus/src/utils/myTheme.dart';
import 'package:opalus/src/views/components/transaction/byGroup/summarizedTopItem.dart';

class TotalBar extends StatelessWidget implements PreferredSizeWidget {
  final int total;
  Size get preferredSize => const Size.fromHeight(80);

  TotalBar({required this.total});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SummarizedTopItem(
        title: CONSTANT_TEXT.TOTAL,
        amount: convertToCurrency(
          total,
          style: MyTheme.bigCurrency(context),
        ),
      ),
    );
  }
}
