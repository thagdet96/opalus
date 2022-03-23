import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';
import 'package:opalus/src/blocs/transactionNavBar/transactionNavBarBloc.dart';
import 'package:opalus/src/blocs/transactionNavBar/transactionNavBarEvent.dart';
import 'package:opalus/src/models/response/groupTransactions.dart';
import 'package:opalus/src/services/transaction.dart';
import 'package:opalus/src/utils/constants.dart';
import 'package:opalus/src/utils/formats.dart';
import 'package:opalus/src/utils/myTheme.dart';

class Calendar extends StatefulWidget {
  final TabController _controller;

  Calendar(this._controller, {Key? key}) : super(key: key);

  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
  final _bloc = TransactionNavBarBloc();

  DateTime? _firstDate;
  DateTime? _lastDate;
  int? _pageIndex;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: TransactionService().getAndGroupByDate(DateTime.now(), false, _firstDate, _lastDate),
        builder: (context, AsyncSnapshot<List<GroupTransaction>> snapshot) {
          if (snapshot.data != null && snapshot.connectionState == ConnectionState.done) {
            final pageController = CellCalendarPageController(initialPage: _pageIndex);

            return CellCalendar(
              events: getCalendarEvents(snapshot.data),
              cellCalendarPageController: pageController,
              onCellTapped: (DateTime date) {
                widget._controller.animateTo(1);
                Future.delayed(Duration(milliseconds: 300), () => _bloc.eventSink.add(SelectDateEvent(date)));
              },
              onPageChanged: (firstDate, lastDate, pageIndex) {
                setState(() {
                  _firstDate = firstDate;
                  _lastDate = lastDate;
                  _pageIndex = pageIndex;
                });
              },
            );
          } else {
            return Center(
              child: SizedBox(
                width: 150,
                height: 150,
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  List<CalendarEvent> getCalendarEvents(data) {
    List<CalendarEvent> _events = [];

    for (GroupTransaction totalByDay in data) {
      List<CalendarEvent> newEvents = totalByDay
          .toMap()
          .entries
          .where(
            (entry) => [
              TRANSACTION_TYPE.INCOME,
              TRANSACTION_TYPE.OUTCOME,
            ].contains(entry.key),
          )
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
                eventDate: totalByDay.time,
                eventBackgroundColor: Colors.transparent,
              ))
          .toList();
      _events += newEvents;
    }

    return _events;
  }
}
