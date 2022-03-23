import 'package:opalus/src/models/core/transaction.dart';
import 'package:opalus/src/models/response/groupTransactionsByTag.dart';

class TotalTransactionByTag {
  final String type;
  final int total;
  final List<GroupTransactionByTag>? groupTransactionByTag;

  TotalTransactionByTag({required this.type, required this.total, this.groupTransactionByTag});
}
