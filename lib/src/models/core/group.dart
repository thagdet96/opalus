import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:opalus/src/models/core/tag.dart';
import 'package:opalus/src/services/tag.dart';

class Group {
  final String id;
  final String name;
  final List<Tag>? tags;
  final int? budget;
  Group({
    required this.id,
    required this.name,
    this.tags,
    this.budget,
  });

  Group copyWith({
    String? id,
    String? name,
    List<Tag>? tags,
    int? budget,
  }) {
    return Group(
      id: id ?? this.id,
      name: name ?? this.name,
      tags: tags ?? this.tags,
      budget: budget ?? this.budget,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'tags': tags?.map((x) => x.id).join(','),
      'budget': budget,
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    List<Tag> tags = map['tags'] is List ? List.from(map['tags']) : [];

    return Group(
      id: map['id'],
      name: map['name'],
      tags: tags,
      budget: map['budget'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Group.fromJson(String source) => Group.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Group(id: $id, name: $name, tags: $tags, budget: $budget)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Group &&
        other.id == id &&
        other.name == name &&
        listEquals(other.tags, tags) &&
        other.budget == budget;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ tags.hashCode ^ budget.hashCode;
  }

  static String dbName = 'groups';

  static String get createTable {
    return '''
      CREATE TABLE $dbName (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        tags TEXT,
        budget INTEGER
      )
    ''';
  }
}
