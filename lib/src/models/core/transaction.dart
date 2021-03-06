import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:opalus/src/models/core/group.dart';
import 'package:opalus/src/models/core/tag.dart';

class Transaction {
  final String id;
  final String type;
  final int amount;
  final DateTime time;
  final String? title;
  // final List<Group>? groups;
  final List<Tag>? tags;
  final dynamic? metadata;

  Transaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.time,
    this.title,
    // required this.groups,
    this.tags,
    this.metadata,
  });

  Transaction copyWith({
    String? id,
    String? type,
    int? amount,
    DateTime? time,
    String? title,
    // List<Group>? groups,
    List<Tag>? tags,
    dynamic? metadata,
  }) {
    return Transaction(
      id: id ?? this.id,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      time: time ?? this.time,
      title: title ?? this.title,
      // groups: groups ?? this.groups,
      tags: tags ?? this.tags,
      metadata: metadata ?? this.metadata,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'amount': amount,
      'time': time.millisecondsSinceEpoch,
      'title': title,
      // 'groups': groups.map((x) => x.id).join(','),
      'tags': tags?.map((x) => x.id).join(','),
      'metadata': metadata,
    };
  }

  Map<String, dynamic> toRawMap() {
    return {
      'id': id,
      'type': type,
      'amount': amount,
      'time': time.millisecondsSinceEpoch,
      'title': title,
      // 'groups': groups,
      'tags': tags,
      'metadata': metadata,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    // List<Group> groups = map['groups'] is List ? List.from(map['groups']) : [];
    List<Tag> tags = map['tags'] is List ? List.from(map['tags']) : [];

    return Transaction(
      id: map['id'],
      type: map['type'],
      amount: map['amount'],
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
      title: map['title'],
      // groups: groups,
      tags: tags,
      metadata: map['metadata'],
    );
  }

  factory Transaction.fromRawMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      type: map['type'],
      amount: map['amount'],
      time: map['time'],
      title: map['title'],
      // groups: map['groups'],
      tags: map['tags'],
      metadata: map['metadata'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) => Transaction.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Transaction(id: $id, type: $type, amount: $amount, time: $time, title: $title, tags: $tags, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Transaction &&
        other.id == id &&
        other.type == type &&
        other.amount == amount &&
        other.time == time &&
        other.title == title &&
        // listEquals(other.groups, groups) &&
        listEquals(other.tags, tags) &&
        other.metadata == metadata;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        type.hashCode ^
        amount.hashCode ^
        time.hashCode ^
        title.hashCode ^
        // groups.hashCode ^
        tags.hashCode ^
        metadata.hashCode;
  }

  static String dbName = 'transactions';

  static String get createTable {
    return '''
      CREATE TABLE $dbName (
        id TEXT PRIMARY KEY,
        type TEXT NOT NULL,
        amount INTEGER NOT NULL,
        time INTERGER NOT NULL,
        title TEXT,
        groups TEXT,
        tags TEXT,
        metadata TEXT
      );
    ''';
  }
}
