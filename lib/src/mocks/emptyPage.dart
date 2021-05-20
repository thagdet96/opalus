import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  final String text;

  EmptyPage(this.text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(text),
    );
  }
}
