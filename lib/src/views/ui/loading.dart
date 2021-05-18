import 'package:flutter/material.dart';
import 'package:opalus/src/utils/myTheme.dart';
import './home.dart';
import 'package:splashscreen/splashscreen.dart';

class LoadingScreen extends StatelessWidget {
  Future<Widget> loadFromFuture() async {
    // <fetch data from server>

    await Future.delayed(const Duration(seconds: 2));
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
