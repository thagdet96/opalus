import 'package:opalus/src/models/core/transaction.dart';
import 'package:opalus/src/models/reponse/groupTransactions.dart';
import 'package:opalus/src/services/base.dart';
import 'package:opalus/src/services/group.dart';
import 'package:opalus/src/services/tag.dart';
import 'package:opalus/src/utils/notiHandler.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

class TransactionService extends BaseService<Transaction> {
  @override
  final dbName = Transaction.dbName;
  final Map<String, BaseService> mappingFields = {
    'tags': TagService(),
    'groups': GroupService(),
  };

  @override
  Transaction fromMap(Map<String, dynamic> map) {
    return Transaction.fromMap(map);
  }

  @override
  Map<String, dynamic> toMap(Transaction model) {
    return model.toMap();
  }

  Future<List<Map<String, dynamic>>> getRawBetween(
    DateTime upper,
    DateTime lower,
  ) async {
    try {
      sqflite.Database db = await instance.database;

      return db.query(
        dbName,
        where: 'time BETWEEN ? AND ?',
        whereArgs: [upper.millisecondsSinceEpoch, lower.millisecondsSinceEpoch],
      );
    } catch (err) {
      toastError(err);
      return [];
    }
  }

  Future<List<GroupTransaction>> getAndGroupByDate(
    DateTime date, [
    bool expand = false,
  ]) async {
    List<Map<String, dynamic>> raw = await getRawBetween(
      DateTime(date.year, date.month, 1),
      date,
    );

    var transactions =
        expand ? (await join(raw)).map(fromMap) : raw.map(fromMap);
    List<GroupTransaction> group = transactions.fold([], (cur, trans) {
      int index = cur.indexWhere((group) => group.time.day == trans.time.day);
      var group = index != -1
          ? cur[index]
          : GroupTransaction(
              time: trans.time,
              income: 0,
              outcome: 0,
              transactions: [],
            );

      var mapped = group.toMap();
      mapped[trans.type] += trans.amount;
      mapped['transactions'].add(trans);
      var newGroup = GroupTransaction.fromMap(mapped);

      if (index != -1) {
        cur[index] = newGroup;
      } else {
        cur.add(newGroup);
      }

      return cur;
    });

    return group;
  }

  Future<List<GroupTransaction>> getAndGroupByWeek(DateTime date) async {
    List<Map<String, dynamic>> raw = await getRawBetween(
      DateTime(date.year, date.month, 1),
      date,
    );

    var transactions = raw.map(fromMap);
    List<GroupTransaction> group = transactions.fold([], (cur, trans) {
      DateTime startDate = trans.time.subtract(
        Duration(days: trans.time.weekday - 1),
      );
      int index = cur.indexWhere(
        (group) => group.time.day == startDate.day,
      );
      var group = index != -1
          ? cur[index]
          : GroupTransaction(
              time: startDate,
              income: 0,
              outcome: 0,
              transactions: [],
            );

      var mapped = group.toMap();
      mapped[trans.type] += trans.amount;
      var newGroup = GroupTransaction.fromMap(mapped);

      if (index != -1) {
        cur[index] = newGroup;
      } else {
        cur.add(newGroup);
      }

      return cur;
    });

    return group;
  }

  Future<List<GroupTransaction>> getAndGroupByMonth(DateTime date) async {
    List<Map<String, dynamic>> raw = await getRawBetween(
      DateTime(date.year, 1, 1),
      date,
    );

    var transactions = raw.map(fromMap);
    List<GroupTransaction> group = transactions.fold([], (cur, trans) {
      int index = cur.indexWhere(
        (group) => group.time.month == trans.time.month,
      );
      var group = index != -1
          ? cur[index]
          : GroupTransaction(
              time: trans.time,
              income: 0,
              outcome: 0,
              transactions: [],
            );

      var mapped = group.toMap();
      mapped[trans.type] += trans.amount;
      var newGroup = GroupTransaction.fromMap(mapped);

      if (index != -1) {
        cur[index] = newGroup;
      } else {
        cur.add(newGroup);
      }

      return cur;
    });

    return group;
  }
}
