import 'package:flutter/material.dart';
import './home.dart';
import 'package:splashscreen/splashscreen.dart';

class LoadingScreen extends StatelessWidget {
  Future<Widget> loadFromFuture() async {
    // <fetch data from server>

    await Future.delayed(const Duration(seconds: 10));
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
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24.0),
        ),
        image: Image.asset('assets/gif/loading.gif'),
        backgroundColor: Colors.green,
        photoSize: 100.0,
        useLoader: false,
      ),
    );
  }
}
