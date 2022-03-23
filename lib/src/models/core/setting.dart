import 'dart:convert';

class Setting {
  final String id;
  final String name;
  final dynamic value;
  Setting({
    required this.id,
    required this.name,
    required this.value,
  });

  Setting copyWith({
    String? id,
    String? name,
    dynamic? value,
  }) {
    return Setting(
      id: id ?? this.id,
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'value': json.encode(value),
    };
  }

  factory Setting.fromMap(Map<String, dynamic> map) {
    return Setting(
      id: map['id'] as String,
      name: map['name'] as String,
      value: json.decode(map['value']) as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory Setting.fromJson(String source) => Setting.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Setting(id: $id, name: $name, value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Setting && other.id == id && other.name == name && other.value == value;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ value.hashCode;

  static String dbName = 'settings';

  static String get createTable {
    return '''
      CREATE TABLE $dbName (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        value TEXT
      )
    ''';
  }
}
