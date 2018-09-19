import 'dart:async';
import 'dart:io';
import 'package:notodo_app/model/nodoitem.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper{

  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  // factoy constructor which will allow to cache all states of db helper
  factory DatabaseHelper() => _instance;

  final String tableName = "nodoTbl";
  final String columnId = "id";
  final String columnItemname = "itemName";
  final String columnDateCreated = "dateCreated";

  static Database _db;

  Future<Database> get db async{
    if(_db !=null){

      return _db;

    }
    _db = await initDb();

    return _db;

  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path,"notodo.db"); //home://directory/files/maindb.db

    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);

    return ourDb;
  }
  /*
    id | itemName | dateCreated
    -------------------------
    1  | Dothis    | sep10
    2  | Dothat   | sep11
   */

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, $columnItemname TEXT, $columnDateCreated TEXT)");

  }

  //CRUD - CREATE, READ, UPDATE, DELETE

  //Insertion
  Future<int> saveItem(NoDoItem item) async{
    var dbClient = await db;
    int res = await dbClient.insert("$tableName", item.toMap());

    return res;
  }

  Future<List> getItems() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableName ORDER BY $columnItemname ASC"); //Ascending order

    return result.toList();
  }

  //Get Users

  Future<NoDoItem> getItem(int id) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableName WHERE ID = $id");
    if(result.length == 0) return null;
    return new NoDoItem.fromMap(result.first);
  }

  // Get Count
  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery(
            "SELECT COUNT(*) FROM $tableName"));
  }



  // DELETE USER
  Future<int> deleteItem(int id) async{
    var dbClient = await db;

    return await dbClient.delete(tableName,
        where: "$columnId = ?", whereArgs: [id]);
  }

  // UPDATE
  Future<int> updateItem(NoDoItem item) async{
    var dbClient = await db;
    return await dbClient.update(tableName,
        item.toMap(), where: "$columnId = ?", whereArgs: [item.id]);
  }
  Future close() async{
    var dbClient = await db;
    return dbClient.close();
  }

}