import 'dart:convert';

class Tag {
  final String id;
  final String name;
  final String? loop;
  Tag({
    required this.id,
    required this.name,
    this.loop,
  });

  Tag copyWith({
    String? id,
    String? name,
    String? loop,
  }) {
    return Tag(
      id: id ?? this.id,
      name: name ?? this.name,
      loop: loop ?? this.loop,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'loop': loop,
    };
  }

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      id: map['id'],
      name: map['name'],
      loop: map['loop'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Tag.fromJson(String source) => Tag.fromMap(json.decode(source));

  @override
  String toString() => 'Tag(id: $id, name: $name, loop: $loop)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Tag && other.id == id && other.name == name && other.loop == loop;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ loop.hashCode;

  static String dbName = 'tags';

  static String get createTable {
    return '''
      CREATE TABLE $dbName (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        loop TEXT
      )
    ''';
  }
}
