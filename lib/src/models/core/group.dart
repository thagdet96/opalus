import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:opalus/src/models/tag.dart';

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
      'tags': tags?.map((x) => x.toMap()).toList(),
      'budget': budget,
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      id: map['id'],
      name: map['name'],
      tags: List<Tag>.from(map['tags']?.map((x) => Tag.fromMap(x))),
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
}
