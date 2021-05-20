import 'dart:async';
import 'package:opalus/src/blocs/bottomBar/bottomBarEvent.dart';
import 'package:opalus/src/blocs/bottomBar/bottomBarState.dart';

class BottomBarBloc {
  static final BottomBarBloc _singleton = new BottomBarBloc._internal();
  BottomBarState _bottomBarState = BottomBarState(0);

  final _stateController = StreamController<BottomBarState>.broadcast();
  StreamSink<BottomBarState> get inIndex => _stateController.sink;
  Stream<BottomBarState> get index => _stateController.stream;

  final _eventController = StreamController<BottomBarEvent>();
  Sink<BottomBarEvent> get eventSink => _eventController.sink;

  factory BottomBarBloc() {
    return _singleton;
  }

  BottomBarBloc._internal() {
    _eventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(BottomBarEvent event) {
    _bottomBarState = BottomBarState(event.index);

    inIndex.add(_bottomBarState);
  }

  void dispose() {
    _stateController.close();
    _eventController.close();
  }
}
