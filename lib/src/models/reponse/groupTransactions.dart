import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:opalus/src/models/index.dart';

class GroupTransaction {
  final DateTime time;
  final int income;
  final int outcome;
  final List<Transaction>? transactions;

  GroupTransaction({
    required this.time,
    required this.income,
    required this.outcome,
    this.transactions,
  });

  GroupTransaction copyWith({
    DateTime? time,
    int? income,
    int? outcome,
    List<Transaction>? transactions,
  }) {
    return GroupTransaction(
      time: time ?? this.time,
      income: income ?? this.income,
      outcome: outcome ?? this.outcome,
      transactions: transactions ?? this.transactions ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'time': time.millisecondsSinceEpoch,
      'income': income,
      'outcome': outcome,
      'transactions': transactions,
    };
  }

  factory GroupTransaction.fromMap(Map<String, dynamic> map) {
    return GroupTransaction(
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
      income: map['income'],
      outcome: map['outcome'],
      transactions: List<Transaction>.from(map['transactions']),
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupTransaction.fromJson(String source) =>
      GroupTransaction.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GroupTransaction(time: $time, income: $income, outcome: $outcome, transactions: $transactions)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GroupTransaction &&
        other.time == time &&
        other.income == income &&
        other.outcome == outcome &&
        listEquals(other.transactions, transactions);
  }

  @override
  int get hashCode {
    return time.hashCode ^
        income.hashCode ^
        outcome.hashCode ^
        transactions.hashCode;
  }
}
