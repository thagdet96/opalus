import 'package:flutter/material.dart';
import 'package:opalus/src/utils/myTheme.dart';
import './modalBottomSheet.dart';

class AddTransactionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: MyTheme.primaryColor(),
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return ModalBottomSheet();
          },
        );
      },
    );
  }
}
