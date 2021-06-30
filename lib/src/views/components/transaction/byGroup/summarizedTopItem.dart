import 'package:flutter/material.dart';

class SummarizedTopItem extends StatelessWidget {
  final String title;
  final Widget amount;

  SummarizedTopItem({required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          amount,
        ],
      ),
    );
  }
}
