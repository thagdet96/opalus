import 'package:flutter/material.dart';
import 'package:opalus/src/models/index.dart';
import 'package:opalus/src/utils/constants.dart';
import 'package:opalus/src/utils/formats.dart';

class TransactionRow extends StatelessWidget {
  final Transaction transaction;

  TransactionRow(this.transaction);

  @override
  Widget build(BuildContext context) {
    List<Tag> tags = transaction.tags ?? [];

    return ListTile(
      visualDensity: VisualDensity(vertical: -2),
      leading: Container(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: transaction.groups.map(getName).toList(),
        ),
      ),
      title: getName(transaction),
      subtitle: Text(
        tags.map((t) => t.name).join(', '),
        style: TextStyle(height: 0.5),
      ),
      trailing: convertToCurrency(
        transaction.amount,
        style: TextStyle(
          color: this.transaction.type == TRANSACTION_TYPE['INCOME']
              ? Colors.green
              : Colors.red,
        ),
      ),
    );
  }
}
