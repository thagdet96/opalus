import 'package:flutter/material.dart';
import 'detailForm.dart';

class TransactionDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: TransactionDetailForm(),
    );
  }
}
