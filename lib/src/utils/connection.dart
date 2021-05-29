import 'package:opalus/src/models/index.dart' as Models;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String DB_NAME = "opalus_database.db";

class Connection {
  static final Connection instance = Connection._internal();
  Database? _database;
  final List<String> models = [
    Models.Transaction.createTable,
    Models.Group.createTable,
    Models.Tag.createTable,
  ];

  Connection._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await Future.forEach(models, (String query) async {
      await db.execute(query);
    });
  }

  Future close() {
    return _database!.close();
  }

  Future isDBExist() async {
    return databaseExists(join(await getDatabasesPath(), DB_NAME));
  }

  //delete the database
  Future deleteDB() async {
    return deleteDatabase(join(await getDatabasesPath(), DB_NAME));
  }
}
