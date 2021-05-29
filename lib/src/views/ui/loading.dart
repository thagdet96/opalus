import 'package:flutter/material.dart';
import 'package:opalus/src/mocks/group.dart';
import 'package:opalus/src/mocks/tag.dart';
import 'package:opalus/src/mocks/transaction.dart';
import 'package:opalus/src/models/core/transaction.dart';
import 'package:opalus/src/services/group.dart';
import 'package:opalus/src/services/tag.dart';
import 'package:opalus/src/services/transaction.dart';
import 'package:opalus/src/utils/connection.dart';
import 'package:opalus/src/utils/myTheme.dart';
import './home.dart';
import 'package:splashscreen/splashscreen.dart';

class LoadingScreen extends StatelessWidget {
  Future<Widget> loadFromFuture() async {
    bool isDBExist = await Connection.instance.isDBExist();
    if (!isDBExist) {
      TransactionService transactionService = TransactionService();
      GroupService groupService = GroupService();
      TagService tagService = TagService();

      Future.wait(mockTransactions.map(transactionService.insert));
      Future.wait(mockTags.map(tagService.insert));
      Future.wait(mockGroups.map(groupService.insert));
    } else {
      await Future.delayed(const Duration(seconds: 2));
      var t = await TagService().getAll();
      print(t);
    }

    return Future.value(MyHomePage(title: 'Money management'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SplashScreen(
        navigateAfterFuture: loadFromFuture(),
        loadingText: Text(
          'Opalus',
          style: TextStyle(
              color: MyTheme.secondaryColor(),
              fontWeight: FontWeight.bold,
              fontSize: 24.0),
        ),
        image: Image.asset('assets/gif/loading.gif'),
        backgroundColor: MyTheme.primaryColor(),
        photoSize: 100.0,
        useLoader: false,
      ),
    );
  }
}
