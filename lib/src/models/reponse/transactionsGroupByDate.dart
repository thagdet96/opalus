import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:opalus/src/models/index.dart';

class TransactionsGroupByDate {
  final DateTime date;
  final List<Transaction> transactions;

  TransactionsGroupByDate({
    required this.date,
    required this.transactions,
  });

  TransactionsGroupByDate copyWith({
    DateTime? date,
    List<Transaction>? transactions,
  }) {
    return TransactionsGroupByDate(
      date: date ?? this.date,
      transactions: transactions ?? this.transactions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date.millisecondsSinceEpoch,
      'transactions': transactions.map((x) => x.toMap()).toList(),
    };
  }

  factory TransactionsGroupByDate.fromMap(Map<String, dynamic> map) {
    return TransactionsGroupByDate(
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      transactions: List<Transaction>.from(
          map['transactions']?.map((x) => Transaction.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionsGroupByDate.fromJson(String source) =>
      TransactionsGroupByDate.fromMap(json.decode(source));

  @override
  String toString() =>
      'TransactionsGroupByDate(date: $date, transactions: $transactions)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is TransactionsGroupByDate &&
        other.date == date &&
        listEquals(other.transactions, transactions);
  }

  @override
  int get hashCode => date.hashCode ^ transactions.hashCode;
}
