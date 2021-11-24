import 'package:flutter/material.dart';
import 'package:opalus/src/models/core/transaction.dart';
import 'package:opalus/src/services/transaction.dart';
import 'package:opalus/src/utils/notiHandler.dart';
import 'package:uuid/uuid.dart';

class SaveButton extends StatelessWidget {
  final Map<String, dynamic> model;
  final Function actionAfterSave;
  final GlobalKey<FormState> formKey;

  SaveButton(this.model, {required this.formKey, required this.actionAfterSave});

  @override
  Widget build(BuildContext context) {
    if (model['id'] != null) {
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                var form = formKey.currentState;
                if (form != null && form.validate()) {
                  form.save();

                  Transaction transaction = Transaction.fromRawMap(model);
                  await TransactionService().update(model['id'], transaction);
                  Navigator.pop(context);
                  toastSuccess('Transaction updated');
                }
              },
              child: Text('Save'),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                await TransactionService().delete(model['id']);
                Navigator.pop(context);
                toastSuccess('Transaction Deleted');
              },
              child: Text('Delete'),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
            ),
          ),
        ],
      );
    } else {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            var form = formKey.currentState;
            if (form != null && form.validate()) {
              form.save();

              String id = Uuid().v4();
              model['id'] = id;
              Transaction transaction = Transaction.fromRawMap(model);
              await TransactionService().insert(transaction);

              actionAfterSave();
              toastSuccess('Transaction created');
            }
          },
          child: Text('Save'),
        ),
      );
    }
  }
}
