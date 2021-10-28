import 'package:flutter_masked_text/flutter_masked_text.dart';

const errorMessage = 'This field is required';

class Model {
  final String id;
  Model(this.id);
}

final moneyController = MoneyMaskedTextController(
  precision: 0,
  decimalSeparator: '',
);

List<T> getSelectedId<T>(Map<String, bool> selected, List<T>? models) {
  if (models == null) return [];

  var tapped = Map.of(selected);
  tapped.removeWhere((key, value) => !value);
  return tapped.keys
      .map((String id) => models.firstWhere((m) => (m as dynamic).id == id))
      .toList();
}
