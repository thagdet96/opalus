import 'package:flutter/cupertino.dart';
import 'package:opalus/src/models/core/group.dart';
import 'package:opalus/src/models/core/tag.dart';

class DetailFormState {
  List<dynamic> models = [];
  List<Group>? groups;
  Map<String, bool> groupsSelected = {};
  List<Tag>? tags;
  Map<String, bool> tagsSelected = {};
  TextEditingController? controller;

  DetailFormState({
    this.models = const [],
    this.controller,
    this.groups,
    this.tags,
    this.groupsSelected = const {},
    this.tagsSelected = const {},
  });
}
