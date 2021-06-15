import 'dart:async';
import 'package:opalus/src/blocs/transactionNavBar/transactionNavBarEvent.dart';
import 'package:opalus/src/blocs/transactionNavBar/transactionNavBarState.dart';

class TransactionNavBarBloc {
  static final TransactionNavBarBloc _singleton =
      new TransactionNavBarBloc._internal();
  TransactionNavBarState _navBarState = TransactionNavBarState(DateTime.now());

  final _stateController =
      StreamController<TransactionNavBarState>.broadcast(sync: true);
  StreamSink<TransactionNavBarState> get updateState => _stateController.sink;
  Stream<TransactionNavBarState> get state => _stateController.stream;

  final _eventController = StreamController<TransactionNavBarEvent>();
  Sink<TransactionNavBarEvent> get eventSink => _eventController.sink;

  factory TransactionNavBarBloc() {
    return _singleton;
  }

  TransactionNavBarBloc._internal() {
    _eventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(TransactionNavBarEvent event) {
    if (event is SelectDateEvent) {
      _navBarState = TransactionNavBarState(event.selectedDate);
    }

    updateState.add(_navBarState);
  }

  TransactionNavBarState get navBarState => _navBarState;

  void dispose() {
    _stateController.close();
    _eventController.close();
  }
}
