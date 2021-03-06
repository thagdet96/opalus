import 'package:flutter/material.dart';
import 'package:opalus/src/models/core/transaction.dart';
import 'package:opalus/src/utils/myTheme.dart';
import '../transactionDetail/transactionDetail.dart';

class ModalBottomSheet extends StatelessWidget {
  final Transaction? transaction;

  ModalBottomSheet({this.transaction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQueryData.fromWindow(WidgetsBinding.instance!.window).padding,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.navigate_before,
                color: MyTheme.secondaryColor(),
                size: kToolbarHeight * 0.8,
              ),
              onPressed: () => Navigator.pop(context)),
        ),
        body: Padding(
          padding: EdgeInsets.all(12),
          child: TransactionDetail(transaction: transaction),
        ),
      ),
    );
  }
}
