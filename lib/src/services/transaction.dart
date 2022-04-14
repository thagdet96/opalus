import 'package:opalus/src/models/core/tag.dart';
import 'package:opalus/src/models/core/transaction.dart';
import 'package:opalus/src/models/response/groupTransactions.dart';
import 'package:opalus/src/models/response/groupTransactionsByTag.dart';
import 'package:opalus/src/models/response/summarizeTag.dart';
import 'package:opalus/src/models/response/totalSummarizeTag.dart';
import 'package:opalus/src/models/response/totalTransactionByTag.dart';
import 'package:opalus/src/services/base.dart';
import 'package:opalus/src/services/tag.dart';
import 'package:opalus/src/utils/constants.dart';
import 'package:opalus/src/utils/notiHandler.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

class TransactionService extends BaseService<Transaction> {
  @override
  final dbName = Transaction.dbName;
  final Map<String, BaseService> mappingFields = {
    'tags': TagService(),
    // 'groups': GroupService(),
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
    DateTime? startDate,
    DateTime? endDate,
  ]) async {
    if (startDate == null) {
      startDate = DateTime(date.year, date.month, 1);
    }

    if (endDate == null) {
      endDate = DateTime(date.year, date.month + 1, 0);
    }

    List<Map<String, dynamic>> raw = await getRawBetween(
      startDate,
      endDate,
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

    group.sort((g1, g2) => g1.time.compareTo(g2.time));
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

  Future<TotalTransactionByTag> getAndGroupByTag(
    DateTime startDate,
    DateTime endDate, {
    String type = TRANSACTION_TYPE.OUTCOME,
    List<String>? tagIds,
  }) async {
    try {
      sqflite.Database db = await instance.database;

      List<Map<String, dynamic>> raw = await db.query(
        dbName,
        where: '( time BETWEEN ? AND ? ) AND ( type = ? )',
        whereArgs: [
          startDate.millisecondsSinceEpoch,
          endDate.millisecondsSinceEpoch,
          type
        ],
      );

      List<Map<String, dynamic>> filtered = tagIds == null
          ? raw
          : raw
              .where(
                (e) => tagIds.any((id) => e['tags'].contains(id)),
              )
              .toList();

      var transactions = (await join(filtered)).map(fromMap);
      int total = 0;
      List<Transaction> otherTransactions = [];
      List<GroupTransactionByTag> groups = transactions.fold([], (cur, trans) {
        total += trans.amount;

        List<Tag> tags = trans.tags ?? [];
        if (tags.isEmpty) {
          otherTransactions.add(trans);
          return cur;
        }

        tags.forEach((tag) {
          int index = cur.indexWhere((g) => g.tag?.id == tag.id);

          var group = index != -1
              ? cur[index]
              : GroupTransactionByTag(
                  tag: tag,
                  type: trans.type,
                  amount: 0,
                  transactions: [],
                );

          var mapped = group.toMap();
          mapped['amount'] += trans.amount;
          mapped['transactions'] += [trans];
          var newGroup = GroupTransactionByTag.fromMap(mapped);

          if (index != -1) {
            cur[index] = newGroup;
          } else {
            cur.add(newGroup);
          }
        });

        return cur;
      });

      if (otherTransactions.isNotEmpty) {
        groups.add(GroupTransactionByTag(
          type: type,
          amount: otherTransactions.fold(
              0, (previousValue, element) => previousValue += element.amount),
          transactions: otherTransactions,
        ));
      }

      return TotalTransactionByTag(
          type: type, total: total, groupTransactionByTag: groups);
    } catch (err) {
      toastError(err);
      return TotalTransactionByTag(
          type: type, total: 0, groupTransactionByTag: []);
    }
  }

  Future<TotalSummarizeTag> summarizeBudgetTag(
    DateTime startDate,
    DateTime endDate,
    List<String> tagIds,
  ) async {
    sqflite.Database db = await instance.database;

    List<Map<String, dynamic>> raw = await db.query(
      dbName,
      where: '( time BETWEEN ? AND ? )',
      whereArgs: [
        startDate.millisecondsSinceEpoch,
        endDate.millisecondsSinceEpoch
      ],
    );

    List<Map<String, dynamic>> filtered = raw
        .where(
          (e) =>
              tagIds.any((id) => e['tags'] != null && e['tags'].contains(id)),
        )
        .toList();

    var transactions = (await join(filtered)).map(fromMap);
    int total = 0;
    List<SummarizeTag> groups = transactions.fold([], (cur, trans) {
      total += trans.amount;

      List<Tag> tags = trans.tags!.where((e) => tagIds.contains(e.id)).toList();

      tags.forEach((tag) {
        int index = cur.indexWhere((g) => g.tag.id == tag.id);

        var group = index != -1
            ? cur[index]
            : SummarizeTag(
                tag: tag,
                amount: 0,
              );

        var mapped = group.toMap();
        mapped['amount'] +=
            (trans.type == TRANSACTION_TYPE.OUTCOME ? 1 : -1) * trans.amount;
        var newGroup = SummarizeTag.fromMap(mapped);

        if (index != -1) {
          cur[index] = newGroup;
        } else {
          cur.add(newGroup);
        }
      });

      return cur;
    });

    return TotalSummarizeTag(total: total, summarizeTags: groups);
  }
}
