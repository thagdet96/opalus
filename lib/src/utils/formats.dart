import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Text getName(dynamic obj, {TextStyle? style}) {
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

    return Text(name, textAlign: TextAlign.center, style: style);
  } catch (e) {
    return Text('');
  }
}

Text convertToCurrency(int amount, {TextStyle? style, TextAlign? textAlign}) {
  return Text(
    NumberFormat.currency(
      locale: 'vi',
      decimalDigits: 0,
    ).format(amount),
    textAlign: textAlign,
    overflow: TextOverflow.ellipsis,
    style: style,
  );
}

Text convertToCurrencyV2(int amount, {TextStyle? style, TextAlign? textAlign}) {
  return Text(
    NumberFormat("###,###").format(amount),
    textAlign: textAlign,
    overflow: TextOverflow.ellipsis,
    style: style,
  );
}

String getRange({required DateTime startDate, required DateTime endDate}) {
  const String pattern = 'dd/MM';

  return DateFormat(pattern).format(startDate) + ' ~ ' + DateFormat(pattern).format(endDate);
}
