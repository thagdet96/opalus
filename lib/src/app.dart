import 'package:flutter/material.dart';
import 'package:opalus/src/views/ui/loading.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green[400],
        accentColor: Colors.purple,
      ),
      home: LoadingScreen(),
    );
  }
}
