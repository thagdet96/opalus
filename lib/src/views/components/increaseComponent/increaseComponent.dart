import 'package:flutter/material.dart';
import 'package:opalus/src/blocs/Transaction/transactionBloc.dart';
import 'package:opalus/src/blocs/Transaction/transactionEvent.dart';
import 'package:opalus/src/blocs/Transaction/transactionState.dart';

class IncreasedApp extends StatelessWidget {
  IncreasedApp({Key? key}) : super(key: key);
  final _bloc = TransactionBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: _bloc.counter,
          initialData: TransactionState(0),
          builder: (BuildContext context, AsyncSnapshot<Object> snapshot) {
            TransactionState transactionState = snapshot.data as TransactionState;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '${transactionState.count}',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () => _bloc.counterEventSink.add(IncrementEvent()),
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
