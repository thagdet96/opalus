import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'utils.dart';

const pattern = 'yyyy-MM-dd';

class TimeInputField extends StatelessWidget {
  late final DateTime _selectedTime;
  final Map<String, dynamic> model;
  final hideOptionsContainer;
  final FocusNode _focus = new FocusNode();

  TimeInputField(this.model, this.hideOptionsContainer) {
    if (model['time'] != null) {
      _selectedTime = model['time'] is DateTime ? model['time'] : DateTime.fromMillisecondsSinceEpoch(model['time']);
    } else {
      _selectedTime = DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    _focus.addListener(hideOptionsContainer);

    return DateTimePicker(
      icon: Icon(
        Icons.access_time_outlined,
      ),
      type: DateTimePickerType.date,
      initialDate: _selectedTime,
      dateMask: 'dd / MM / yyyy ( EE )',
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),
      dateLabelText: 'Date',
      initialValue: DateFormat(pattern).format(_selectedTime),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return errorMessage;
        }
        return null;
      },
      onSaved: (String? value) {
        model['time'] = DateFormat(pattern).parse(value!);
      },
      focusNode: _focus,
    );
  }
}
