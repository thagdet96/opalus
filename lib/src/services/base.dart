import 'package:opalus/src/utils/connection.dart';
import 'package:sqflite/sqflite.dart';

class BaseService<T> {
  final instance = Connection.instance;
  String dbName = '';
  Map<String, BaseService> mappingFields = Map();

  Future<int> insert(T model) async {
    Database db = await instance.database;

    return await db.insert(
      dbName,
      toMap(model),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<T>> getAll() async {
    Database db = await instance.database;

    List<Map<String, dynamic>> raw = await db.query(dbName);

    return raw.map(fromMap).toList();
  }

  Future<T> getById(String id) async {
    Database db = await instance.database;

    List<Map<String, dynamic>> raw = await db.query(
      dbName,
      distinct: true,
      where: 'id = ?',
      whereArgs: [id],
    );

    var mapped = await join(raw);

    return fromMap(mapped.first);
  }

  /*
   * Param String ids List of id seperated by ','. For example: 1,2,3 
   */
  Future<List<T>> getByListId(String ids) async {
    Database db = await instance.database;

    List<Map<String, dynamic>> raw = await db.query(
      dbName,
      where: 'id IN ($ids)',
    );

    var mapped = await join(raw);

    return mapped.map(fromMap).toList();
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
                (id) => fieldData.firstWhere((data) => data.id == id),
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
