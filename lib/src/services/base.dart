import 'package:opalus/src/utils/connection.dart';
import 'package:opalus/src/utils/notiHandler.dart';
import 'package:sqflite/sqflite.dart';

class BaseService<T> {
  final instance = Connection.instance;
  String dbName = '';
  Map<String, BaseService> mappingFields = Map();

  Future<int> insert(T model) async {
    try {
      Database db = await instance.database;

      return await db.insert(
        dbName,
        toMap(model),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (err) {
      toastError(err);
      return 0;
    }
  }

  Future<List<T>> getAll() async {
    try {
      Database db = await instance.database;

      List<Map<String, dynamic>> raw = await db.query(dbName);

      return raw.map(fromMap).toList();
    } catch (err) {
      toastError(err);
      return [];
    }
  }

  Future<T> getById(String id) async {
    try {
      Database db = await instance.database;

      List<Map<String, dynamic>> raw = await db.query(
        dbName,
        distinct: true,
        where: 'id = ?',
        whereArgs: [id],
      );

      var mapped = await join(raw);

      return fromMap(mapped.first);
    } catch (err) {
      toastError(err);
      return null as T;
    }
  }

  /*
   * Param String ids List of id seperated by ','. For example: 1,2,3 
   */
  Future<List<T>> getByListId(String ids) async {
    try {
      Database db = await instance.database;

      List<Map<String, dynamic>> raw = await db.query(
        dbName,
        where: 'id IN ($ids)',
      );

      var mapped = await join(raw);

      return mapped.map(fromMap).toList();
    } catch (err) {
      toastError(err);
      return [];
    }
  }

  T fromMap(Map<String, dynamic> map) {
    return null as T;
  }

  Map<String, dynamic> toMap(T model) {
    return null as dynamic;
  }

  /*
   * Param List<Map> raw raw data get from database
   * Param Map<String, Service> mappingFields fields need to be explode. For example {'tags': TagService()}
   */
  Future<List<Map<String, dynamic>>> join(
    List<Map<String, dynamic>> raw,
  ) async {
    if (mappingFields.isEmpty) return raw;
    List<Map<String, dynamic>> mappedRaw = raw;

    await Future.forEach(mappingFields.entries, (MapEntry entry) async {
      String key = entry.key;
      BaseService service = entry.value;

      List<String> fieldAllIds = raw.fold(
        [],
        (cur, e) => e[key] != null ? cur + e[key].split(',') : cur,
      );

      fieldAllIds.removeWhere((id) => id == '');
      var fieldData = fieldAllIds.isEmpty
          ? []
          : await service.getByListId(fieldAllIds.join(','));

      if (fieldData.isNotEmpty) {
        mappedRaw = mappedRaw.map((e) {
          Map<String, dynamic> clone = Map.from(e);
          List<String> fieldIds =
              clone[key] != null ? clone[key].split(',') : [];
          var mappedField = fieldIds
              .map(
                (id) => fieldData.firstWhere((data) => data.id == id,
                    orElse: () => null),
              )
              .toList();

          clone[key] = mappedField;
          return clone;
        }).toList();
      }
    });

    return mappedRaw;
  }
}
