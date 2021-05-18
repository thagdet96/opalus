import 'dart:async';
import 'package:opalus/src/blocs/Transaction/transactionEvent.dart';
import 'package:opalus/src/blocs/Transaction/transactionState.dart';

class TransactionBloc {
  int _counter = 0;
  TransactionState _transactionState = TransactionState(0);

  final _counterStateController = StreamController<TransactionState>();
  StreamSink<TransactionState> get _inCounter => _counterStateController.sink;
  // For state, exposing only a stream which outputs data
  Stream<TransactionState> get counter => _counterStateController.stream;

  final _counterEventController = StreamController<TransactionEvent>();
  // For events, exposing only a sink which is an input
  Sink<TransactionEvent> get counterEventSink => _counterEventController.sink;

  TransactionBloc() {
    // Whenever there is a new event, we want to map it to a new state
    _counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(TransactionEvent event) {
    if (event is IncrementEvent) {
      _counter++;
      _transactionState = TransactionState(_counter);
    } else {
      _counter--;
    }

    _inCounter.add(_transactionState);
  }

  void dispose() {
    _counterStateController.close();
    _counterEventController.close();
  }
}
