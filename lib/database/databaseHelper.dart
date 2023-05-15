import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sms/database/studentModel.dart';
import 'package:sms/strings.dart';

class DatabaseHelper{

  // Singleton class
  DatabaseHelper._privConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privConstructor();

  static Database? _database ;
  Future<Database?> get database async{
    if (_database!=null) { return _database; }
    _database = await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();   // path_provider => docs dir
    String path = directory.path + StringNotations().databaseName;
    var smsDB = await openDatabase(path, version: 1, onCreate: _createDB);
    return smsDB;
  }

  Future _createDB(Database db, int version) async{
    await db.execute('''CREATE TABLE ${StringNotations().tableName} (
                      ${StringNotations().colId} INTEGER PRIMARY KEY AUTOINCREMENT,
                      ${StringNotations().colPref} TEXT NOT NULL,
                      ${StringNotations().colName} TEXT NOT NULL,
                      ${StringNotations().colEmail} TEXT NOT NULL,
                      ${StringNotations().colPhone} TEXT NOT NULL,
                      ${StringNotations().colCity} TEXT NOT NULL
                    )''');
  }


  // Create Record
  Future<int?> insertRecord(Map<String, dynamic> record) async{
    Database? db = await instance.database;
    return await db?.insert(StringNotations().tableName, record);
  }

  // Read Record
  Future<List<Map<String, dynamic>>?> readRecord() async{
    Database? db = await instance.database;
    return await db?.query(StringNotations().tableName, orderBy: 'ID');
  }

  // Delete Record
  Future<int?> deleteRecord(int id) async{
    Database? db = await instance.database;
    return await db?.delete(StringNotations().tableName, where: '${StringNotations().colId} = ?', whereArgs: [id] );
  }

  // Student exist or not for delete functionality
  Future<bool> checkForStudentId(int id) async{
    bool flag = false;
    int lenOfResultSet = 0;
    int i = 0;

    Database? db = await instance.database;
    final List<Map<String, dynamic>>? resultSetofIDs = await db?.rawQuery('SELECT ID from ${StringNotations().tableName}');
    if(resultSetofIDs!=null) { lenOfResultSet = resultSetofIDs.length; }

    while (i < lenOfResultSet) {
      final ele = resultSetofIDs![i];
      if (id == ele['ID']) {
        flag = true;
        break;
      }
      i++;
    }
    return flag;
  }


  // Update Record
  Future<int?> updateRecord(Map<String, dynamic> record, int id) async{
    Database? db = await instance.database;
    return await db?.update(StringNotations().tableName, record, where: '${StringNotations().colId} = ?', whereArgs: [id] );
  }

  Future<List<Map<String, dynamic>>?> getStudentRecordForUpd(int id) async{
    Database? db = await instance.database;
    return await db?.query(StringNotations().tableName, where: '${StringNotations().colId} = ?', whereArgs: [id] );
  }

}