import 'package:flutter/material.dart';
import 'package:opalus/src/utils/myTheme.dart';
import '../transactionDetail/transactionDetail.dart';

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
            return Padding(
              padding:
                  MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
                      .padding,
              child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                      icon: Icon(
                        Icons.navigate_before,
                        color: MyTheme.secondaryColor(),
                        size: kToolbarHeight * 0.8,
                      ),
                      onPressed: () => Navigator.pop(context)),
                ),
                body: TransactionDetail(),
              ),
            );
          },
        );
      },
    );
  }
}
