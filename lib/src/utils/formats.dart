import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget getName(dynamic obj, {TextStyle? style}) {
  try {
    String name = '';
    dynamic formattedObj = obj.toMap();
    List<String> keys = ['name', 'title'];

    for (final key in keys) {
      if (formattedObj.containsKey(key)) {
        name = formattedObj[key];
        break;
      }
    }

    return Text(name, style: style);
  } catch (e) {
    return Text('');
  }
}

Widget convertToCurrency(int amount, {TextStyle? style, TextAlign? textAlign}) {
  return Text(
    NumberFormat.currency(
      locale: 'vi',
      decimalDigits: 0,
    ).format(amount),
    textAlign: textAlign,
    style: style,
  );
}
