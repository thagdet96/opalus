import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:opalus/src/models/index.dart';

class TransactionsGroupByDate {
  final DateTime date;
  final int income;
  final int outcome;
  final List<Transaction>? transactions;

  TransactionsGroupByDate({
    required this.date,
    required this.income,
    required this.outcome,
    this.transactions,
  });

  TransactionsGroupByDate copyWith({
    DateTime? date,
    int? income,
    int? outcome,
    List<Transaction>? transactions,
  }) {
    return TransactionsGroupByDate(
      date: date ?? this.date,
      income: income ?? this.income,
      outcome: outcome ?? this.outcome,
      transactions: transactions ?? this.transactions ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date.millisecondsSinceEpoch,
      'income': income,
      'outcome': outcome,
      'transactions': transactions?.map((x) => x.toMap()).toList(),
    };
  }

  factory TransactionsGroupByDate.fromMap(Map<String, dynamic> map) {
    return TransactionsGroupByDate(
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      income: map['income'],
      outcome: map['outcome'],
      transactions: List<Transaction>.from(
          map['transactions']?.map((x) => Transaction.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionsGroupByDate.fromJson(String source) =>
      TransactionsGroupByDate.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TransactionsGroupByDate(date: $date, income: $income, outcome: $outcome, transactions: $transactions)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionsGroupByDate &&
        other.date == date &&
        other.income == income &&
        other.outcome == outcome &&
        listEquals(other.transactions, transactions);
  }

  @override
  int get hashCode {
    return date.hashCode ^
        income.hashCode ^
        outcome.hashCode ^
        transactions.hashCode;
  }
}
