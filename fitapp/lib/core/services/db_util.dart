
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbUtil{

  static Future<Database> database() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'database.db');
    return openDatabase(path,  version: 1, onCreate: (db, version) async {
      await db.execute('CREATE TABLE exercises (id TEXT PRIMARY KEY, title TEXT, repetition INTEGER, time TEXT, weekday TEXT)');
    },);
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async{
    final db = await DbUtil.database();
    await db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> remove(String id) async{
    final db = await DbUtil.database();
    await db.delete('exercises', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Map<String, Object?>>> getData(String table) async{
    final db = await DbUtil.database();
    List<Map> lista= await db.query(table);
    print(lista);
    return db.query(table);
  }

}