import 'package:flutter/material.dart';
import 'package:opalus/src/utils/myTheme.dart';
import 'package:opalus/src/views/ui/loading.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: MyTheme.primaryColor(),
        primaryColorLight: MyTheme.primaryColorLight(),
        accentColor: MyTheme.accentColor(),

        fontFamily: 'Oswald', // Define the default font family.
      ),
      home: LoadingScreen(),
    );
  }
}
