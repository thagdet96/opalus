import 'package:flutter/cupertino.dart';

class Model {
  final String id;
  Model(this.id);
}

List<T> getSelectedId<T>(Map<String, bool> selected, List<T>? models) {
  if (models == null) return [];

  var tapped = Map.of(selected);
  tapped.removeWhere((key, value) => !value);
  return tapped.keys.map((String id) => models.firstWhere((m) => (m as dynamic).id == id)).toList();
}

String getSelectedName<T>(List<T> selected) {
  if (selected.isEmpty) return '';

  return selected.map((e) => (e as dynamic).name).join(', ');
}

void clearController(List<TextEditingController> controllers) {
  controllers.forEach((element) {
    element.clear();
  });
}
