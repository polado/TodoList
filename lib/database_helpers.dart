import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final String tableTasks = 'tasks';
final String columnId = '_id';
final String columnName = 'taskName';
final String columnDescription = 'description';
final String columnDate = 'taskDate';
final String columnIsActive = 'isActive';

class Task {
  int id;
  String taskName, description, taskDate;
  bool isActive;

  Task();

  Task.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    taskName = map[columnName];
    description = map[columnDescription];
    taskDate = map[columnDate];
    isActive = (map[columnIsActive] == 1) ? true : false;
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: taskName,
      columnDescription: description,
      columnDate: taskDate,
      columnIsActive: isActive ? 1 : 0
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  @override
  String toString() {
    return '$taskName $description $taskDate';
  }
}

class DatabaseHelper {
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableTasks (
                $columnId INTEGER PRIMARY KEY,
                $columnName TEXT NOT NULL,
                $columnDescription TEXT NOT NULL,
                $columnDate TEXT NOT NULL,
                $columnIsActive INTEGER NOT NULL
              )
              ''');
  }

  Future<int> insert(Task task) async {
    Database db = await database;
    int id = await db.insert(tableTasks, task.toMap());
    return id;
  }

  Future<Task> queryTask(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableTasks,
        columns: [
          columnId,
          columnName,
          columnDescription,
          columnDate,
          columnIsActive
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Task.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Task>> queryActiveTasks() async {
    Database db = await database;
    List<Map> maps = await db.query(tableTasks,
        columns: [
          columnId,
          columnName,
          columnDescription,
          columnDate,
          columnIsActive
        ],
        where: '$columnIsActive = ?',
        whereArgs: [1]);
    if (maps.length > 0) {
      List<Task> list = new List();
      for (int i = 0; i < maps.length; i++) list.add(Task.fromMap(maps[i]));
      return list;
    }
    return null;
  }

  Future<List<Task>> queryInActiveTasks() async {
    Database db = await database;
    List<Map> maps = await db.query(tableTasks,
        columns: [
          columnId,
          columnName,
          columnDescription,
          columnDate,
          columnIsActive
        ],
        where: '$columnIsActive = ?',
        whereArgs: [0]);
    if (maps.length > 0) {
      List<Task> list = new List();
      for (int i = 0; i < maps.length; i++) list.add(Task.fromMap(maps[i]));
      return list;
    }
    return null;
  }

  Future<int> updateActive(Task task) async {
    task.isActive = false;
    Database db = await database;
    int updated = await db.update(tableTasks, task.toMap(),
        where: "$columnId = ?", whereArgs: [task.id]);
    return updated;
  }

  Future<int> updateInActive(Task task) async {
    task.isActive = true;
    Database db = await database;
    int updated = await db.update(tableTasks, task.toMap(),
        where: "$columnId = ?", whereArgs: [task.id]);
    return updated;
  }

  Future<int> delete(int id) async {
    Database db = await database;
    int deleted =
        await db.delete(tableTasks, where: "$columnId = ?", whereArgs: [id]);
    print('$id deleted $deleted');
    return deleted;
  }

  Future<int> deleteMulti(List<int> ids) async {
    Database db = await database;
    String txtIDS = '$columnId = ${ids.first} ';
    for (int i = 1; i < ids.length; i++) {
      txtIDS += 'OR $columnId = ${ids[i]} ';
    }

    print(txtIDS);
    int deleted = await db.delete(tableTasks, where: txtIDS);
//    int deleted =
//        await db.rawDelete('Delete from $tableTasks where $txtIDS',);
    print('deleted $deleted');
    return deleted;
  }
}
