import 'package:flutter/material.dart';
import 'package:opalus/src/utils/formats.dart';

class DateFilter extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final onChangeDate;

  DateFilter({
    required this.startDate,
    required this.endDate,
    this.onChangeDate,
  });

  void openDateRangePicker(context) async {
    final DateTimeRange? range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      initialDateRange: DateTimeRange(start: startDate, end: endDate),
    );

    if (range == null) return;

    onChangeDate(range.start, range.end);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: TextButton(
              onPressed: () => openDateRangePicker(context),
              style: ButtonStyle(alignment: Alignment.centerLeft),
              child: Text(
                'Filter By Date: ' +
                    getRange(
                      startDate: startDate,
                      endDate: endDate,
                    ),
                style: TextStyle(color: Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }
}
