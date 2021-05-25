import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';
import 'package:opalus/src/models/index.dart';
import 'package:opalus/src/utils/constants.dart';
import 'package:opalus/src/utils/formats.dart';
import 'package:opalus/src/utils/myTheme.dart';

class Calendar extends StatelessWidget {
  Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TransactionsGroupByDate> totalByDays = getTotalOfDays();
    List<CalendarEvent> _events = [];
    for (TransactionsGroupByDate totalByDay in totalByDays) {
      List<CalendarEvent> newEvents = totalByDay
          .toMap()
          .entries
          .where((entry) => (entry.key == TRANSACTION_TYPE.INCOME || entry.key == TRANSACTION_TYPE.OUTCOME))
          .map((entry) => CalendarEvent(
                eventName: Container(
                  margin: EdgeInsets.only(left: 3, right: 3),
                  child: entry.value == 0
                      ? Container()
                      : convertToCurrencyV2(
                          entry.value,
                          style: MyTheme.smallCurrency(context, entry.key),
                        ),
                ),
                eventDate: totalByDay.date,
                eventBackgroundColor: Colors.transparent,
              ))
          .toList();
      _events += newEvents;
    }
    return CellCalendar(
      events: _events,
    );
  }

  List<TransactionsGroupByDate> getTotalOfDays() {
    List<TransactionsGroupByDate> totalByDays = [
      TransactionsGroupByDate(date: DateTime(2021, 5, 5), income: 10000000, outcome: 0),
      TransactionsGroupByDate(date: DateTime(2021, 5, 6), income: 10000, outcome: 1000000),
      TransactionsGroupByDate(date: DateTime(2021, 5, 7), income: 0, outcome: 20000),
    ];
    return totalByDays;
  }
}
