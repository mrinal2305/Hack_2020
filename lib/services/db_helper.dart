import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

//if some error occurs try to uninstall then install
class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    final sqlDb = await sql.openDatabase(path.join(dbPath, 'books.db'),
        onCreate: (db, version) async{
          await db.execute(
              'CREATE TABLE user_books (isbn TEXT PRIMARY KEY,title TEXT,imgUrl TEXT,description TEXT,author TEXT)');
        }, version: 1);//carefully close brackets in sql query
    return sqlDb;
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await database();
    return db.query(table);//return whole table contents
  }
}
