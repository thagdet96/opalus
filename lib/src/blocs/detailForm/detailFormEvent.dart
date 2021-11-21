import 'package:flutter/cupertino.dart';

abstract class DetailFormEvent {}

class DetailFormInit<T> extends DetailFormEvent {
  final List<T> models;
  final TextEditingController? controller;

  DetailFormInit(this.models, [this.controller]);
}

class DetailFormTap<T> extends DetailFormEvent {
  final Map<String, bool> tapped;

  DetailFormTap(this.tapped);
}
