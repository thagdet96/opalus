import 'dart:async';
import 'package:opalus/src/models/core/group.dart';
import 'package:opalus/src/models/core/tag.dart';
import 'detailFormEvent.dart';
import 'detailFormState.dart';

class DetailFormBloc {
  static final DetailFormBloc _singleton = new DetailFormBloc._internal();
  DetailFormState _detailFormState = DetailFormState();

  final _stateController = StreamController<DetailFormState>.broadcast();
  StreamSink<DetailFormState> get updateState => _stateController.sink;
  Stream<DetailFormState> get state => _stateController.stream;

  final _eventController = StreamController<DetailFormEvent>();
  Sink<DetailFormEvent> get eventSink => _eventController.sink;

  factory DetailFormBloc() {
    return _singleton;
  }

  DetailFormBloc._internal() {
    _eventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(DetailFormEvent event) {
    if (event is DetailFormInit<Group>) {
      _detailFormState.controller = event.controller;
      _detailFormState.models = event.models;
      _detailFormState.groups = event.models;
    } else if (event is DetailFormInit<Tag>) {
      _detailFormState.controller = event.controller;
      _detailFormState.models = event.models;
      _detailFormState.tags = event.models;
    } else if (event is DetailFormTap<Group>) {
      _detailFormState.groupsSelected = event.tapped;
    } else if (event is DetailFormTap<Tag>) {
      _detailFormState.tagsSelected = event.tapped;
    } else {
      _detailFormState = DetailFormState();
    }

    updateState.add(_detailFormState);
  }

  void dispose() {
    _stateController.close();
    _eventController.close();
  }
}
