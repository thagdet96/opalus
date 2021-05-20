import 'dart:convert';

class TransactionsGroupByWeek {
  final DateTime startDate;
  final DateTime endDate;
  final int income;
  final int outcome;
  TransactionsGroupByWeek({
    required this.startDate,
    required this.endDate,
    required this.income,
    required this.outcome,
  });

  TransactionsGroupByWeek copyWith({
    DateTime? startDate,
    DateTime? endDate,
    int? income,
    int? outcome,
  }) {
    return TransactionsGroupByWeek(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      income: income ?? this.income,
      outcome: outcome ?? this.outcome,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
      'income': income,
      'outcome': outcome,
    };
  }

  factory TransactionsGroupByWeek.fromMap(Map<String, dynamic> map) {
    return TransactionsGroupByWeek(
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate']),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate']),
      income: map['income'],
      outcome: map['outcome'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionsGroupByWeek.fromJson(String source) =>
      TransactionsGroupByWeek.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TransactionsGroupByWeek(startDate: $startDate, endDate: $endDate, income: $income, outcome: $outcome)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionsGroupByWeek &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.income == income &&
        other.outcome == outcome;
  }

  @override
  int get hashCode {
    return startDate.hashCode ^
        endDate.hashCode ^
        income.hashCode ^
        outcome.hashCode;
  }
}
