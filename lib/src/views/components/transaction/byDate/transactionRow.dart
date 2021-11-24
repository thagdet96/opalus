import 'package:flutter/material.dart';
import 'package:opalus/src/models/index.dart';
import 'package:opalus/src/utils/formats.dart';
import 'package:opalus/src/utils/myTheme.dart';
import '../addTransactionButton/modalBottomSheet.dart';

class TransactionRow extends StatelessWidget {
  final Transaction transaction;

  TransactionRow(this.transaction);

  @override
  Widget build(BuildContext context) {
    List<Tag> tags = transaction.tags ?? [];

    return GestureDetector(
      onTap: () => showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return ModalBottomSheet(transaction: transaction);
        },
      ),
      child: Row(children: [
        Container(
          constraints: BoxConstraints(minWidth: 90, minHeight: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: tags.map(getName).toList(),
          ),
        ),
        Expanded(child: getName(transaction)),
        Container(
          width: 80,
          child: convertToCurrency(
            transaction.amount,
            style: MyTheme.regularCurrency(context, transaction.type),
          ),
        ),
      ]),
    );
  }
}
