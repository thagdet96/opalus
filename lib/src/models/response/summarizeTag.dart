import 'dart:convert';
import 'package:opalus/src/models/index.dart';

class SummarizeTag {
  final Tag tag;
  final int amount;
  SummarizeTag({
    required this.tag,
    required this.amount,
  });

  SummarizeTag copyWith({
    Tag? tag,
    int? amount,
  }) {
    return SummarizeTag(
      tag: tag ?? this.tag,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'tag': tag.toMap()});
    result.addAll({'amount': amount});

    return result;
  }

  factory SummarizeTag.fromMap(Map<String, dynamic> map) {
    return SummarizeTag(
      tag: Tag.fromMap(map['tag']),
      amount: map['amount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SummarizeTag.fromJson(String source) =>
      SummarizeTag.fromMap(json.decode(source));

  @override
  String toString() => 'SummarizeTag(tag: $tag, amount: $amount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SummarizeTag && other.tag == tag && other.amount == amount;
  }

  @override
  int get hashCode => tag.hashCode ^ amount.hashCode;
}
