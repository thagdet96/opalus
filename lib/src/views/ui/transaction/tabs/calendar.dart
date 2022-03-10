import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';
import 'package:opalus/src/blocs/transactionNavBar/transactionNavBarBloc.dart';
import 'package:opalus/src/blocs/transactionNavBar/transactionNavBarEvent.dart';
import 'package:opalus/src/models/reponse/groupTransactions.dart';
import 'package:opalus/src/services/transaction.dart';
import 'package:opalus/src/utils/constants.dart';
import 'package:opalus/src/utils/formats.dart';
import 'package:opalus/src/utils/myTheme.dart';

class Calendar extends StatelessWidget {
  Calendar(this._controller, {Key? key}) : super(key: key);
  final _bloc = TransactionNavBarBloc();
  final TabController _controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: TransactionService().getAndGroupByDate(DateTime.now()),
        builder: (context, AsyncSnapshot<List<GroupTransaction>> snapshot) {
          if (snapshot.hasData) {
            List<CalendarEvent> _events = [];

            for (GroupTransaction totalByDay in snapshot.data!) {
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

            return CellCalendar(
              events: _events,
              onCellTapped: (DateTime date) {
                _controller.animateTo(1);
                Future.delayed(Duration(milliseconds: 300), () => _bloc.eventSink.add(SelectDateEvent(date)));
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
}
