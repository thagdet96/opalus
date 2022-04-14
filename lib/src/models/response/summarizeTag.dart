import 'dart:convert';

import 'package:opalus/src/models/index.dart';

class SummarizeTag {
  final Tag tag;
  final int amount;
  final int budget;
  SummarizeTag({
    required this.tag,
    required this.amount,
    required this.budget,
  });

  SummarizeTag copyWith({
    Tag? tag,
    int? amount,
    int? budget,
  }) {
    return SummarizeTag(
      tag: tag ?? this.tag,
      amount: amount ?? this.amount,
      budget: budget ?? this.budget,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'tag': tag.toMap()});
    result.addAll({'amount': amount});
    result.addAll({'budget': budget});

    return result;
  }

  factory SummarizeTag.fromMap(Map<String, dynamic> map) {
    return SummarizeTag(
      tag: Tag.fromMap(map['tag']),
      amount: map['amount']?.toInt() ?? 0,
      budget: map['budget']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SummarizeTag.fromJson(String source) =>
      SummarizeTag.fromMap(json.decode(source));

  @override
  String toString() =>
      'SummarizeTag(tag: $tag, amount: $amount, budget: $budget)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SummarizeTag &&
        other.tag == tag &&
        other.amount == amount &&
        other.budget == budget;
  }

  @override
  int get hashCode => tag.hashCode ^ amount.hashCode ^ budget.hashCode;
}
