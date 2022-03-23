import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:opalus/src/models/core/tag.dart';
import 'package:opalus/src/models/core/transaction.dart';

class GroupTransactionByTag {
  final Tag? tag;
  final String type;
  final int amount;
  final List<Transaction>? transactions;

  GroupTransactionByTag({
    this.tag,
    required this.type,
    required this.amount,
    this.transactions,
  });

  GroupTransactionByTag copyWith({
    Tag? tag,
    String? type,
    int? amount,
    List<Transaction>? transactions,
  }) {
    return GroupTransactionByTag(
      tag: tag ?? this.tag,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      transactions: transactions ?? this.transactions ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tag': tag?.toMap(),
      'type': type,
      'amount': amount,
      'transactions': transactions,
    };
  }

  factory GroupTransactionByTag.fromMap(Map<String, dynamic> map) {
    return GroupTransactionByTag(
      tag: Tag.fromMap(map['tag']),
      type: map['type'] ?? '',
      amount: map['amount']?.toInt() ?? 0,
      transactions: List<Transaction>.from(map['transactions']),
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupTransactionByTag.fromJson(String source) => GroupTransactionByTag.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GroupTransactionByTag(tag: $tag, type: $type, amount: $amount, transactions: $transactions)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is GroupTransactionByTag &&
        other.tag == tag &&
        other.type == type &&
        other.amount == amount &&
        listEquals(other.transactions, transactions);
  }

  @override
  int get hashCode {
    return tag.hashCode ^ type.hashCode ^ amount.hashCode ^ transactions.hashCode;
  }
}
