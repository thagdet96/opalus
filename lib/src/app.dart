import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: MyTheme.secondaryColor()),

        fontFamily: 'Oswald', // Define the default font family.
      ),
      localizationsDelegates: [MonthYearPickerLocalizations.delegate],
      home: LoadingScreen(),
    );
  }
}
