import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "dirtDatabase.db";
  static final _databaseVersion = 3;

  static final tableUser = 'userTable';
  static final columnId = 'id';
  static final columnUsername = 'username';
  static final columnPassword = 'password';

  static final tableChat = 'chatTable';
  static final columnMessage = 'message';
  static final columnUserId = 'userId';

  static final tableUpload = 'uploadTable';
  static final columnWorkName = 'workName';
  static final columnFileType = 'fileType';
  static final columnCollabWorkId = 'collabWorkId';
  static final columnLikes = 'likes';
  static final columnUploaderId = 'uploaderId';



  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate, onUpgrade: onUpgrade,);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableUser (
            $columnId INTEGER PRIMARY KEY,
            $columnUsername TEXT NOT NULL,
            $columnPassword TEXT NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $tableChat (
            $columnId INTEGER PRIMARY KEY,
            $columnMessage TEXT NOT NULL,
            $columnUserId INTEGER,
            FOREIGN KEY ($columnUserId) REFERENCES $tableUser ($columnId)
          )
          ''');
    await db.execute('''
          CREATE TABLE $tableUpload (
            $columnId INTEGER PRIMARY KEY,
            $columnWorkName TEXT NOT NULL,
            $columnFileType TEXT,
            $columnLikes INTEGER DEFAULT 0,
            $columnCollabWorkId INTEGER,
            FOREIGN KEY ($columnCollabWorkId) REFERENCES $tableUpload ($columnId)
          )
      ''');
  }

  Future onUpgrade(Database db, int oldVersion, int newVersion) async {
    // 既存のアップグレードロジック
    if (oldVersion < 2) {
      // バージョン1からバージョン2への変更を追加

      // userTable を再作成
      await db.execute('DROP TABLE IF EXISTS $tableUser');
      await db.execute('''
      CREATE TABLE $tableUser (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnUsername TEXT NOT NULL,
        $columnPassword TEXT NOT NULL
      )
    ''');

      // chatTable を再作成
      await db.execute('DROP TABLE IF EXISTS $tableChat');
      await db.execute('''
      CREATE TABLE $tableChat (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnMessage TEXT NOT NULL,
        $columnUserId TEXT NOT NULL
      )
    ''');

      // uploadTable を再作成
      await db.execute('DROP TABLE IF EXISTS $tableUpload');
      await db.execute('''
      CREATE TABLE $tableUpload (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnWorkName TEXT NOT NULL,
        $columnFileType TEXT NOT NULL
      )
    ''');
    }

    if (oldVersion < 3) {
      // ここでの変更は、tableUploadにcolumnUserIdカラムを追加するものです
      await db.execute('''
      ALTER TABLE $tableUpload 
      ADD $columnUserId INTEGER
    ''');
    }

    // さらに新しいバージョンへの変更が必要な場合、その変更もここに追加します
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row, String tableName) async {
    Database db = await instance.database;
    return await db.insert(tableName, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows(String tableName) async {
    Database db = await instance.database;
    return await db.query(tableName);
  }

  // All the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int?> queryRowCount(String tableName) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tableName'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row, String tableName) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(tableName, row,
        where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id, String tableName) async {
    Database db = await instance.database;
    return await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<Map<String, dynamic>?> getWork(int id) async {
    Database? db = await instance.database;
    var result = await db?.query(tableUpload, where: 'id = ?', whereArgs: [id]);

    if (result != null && result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }
  Future<List<Map<String, dynamic>>> getNotifications() async {
    Database? db = await instance.database;
    var result = await db?.query('notificationsTable'); // 通知情報を保存しているテーブル名を'notificationsTable'と仮定
    return result!;
  }

  Future<List<Map<String, dynamic>>> getLikedWorks() async {
  Database? db = await instance.database;
  // このクエリは「いいね」された作品をすべて取得するものと仮定しています。
  // likesカラムが存在する場合、以下のようにクエリを実行します。
  var result = await db?.query(tableUpload, where: 'likes = ?', whereArgs: [1]);
  return result!;
  }

  Future<List<Map<String, dynamic>>> getDislikedWorks() async {
  Database? db = await instance.database;
  // このクエリは「いいねしない」された作品をすべて取得するものと仮定しています。
  // dislikesカラムが存在する場合、以下のようにクエリを実行します。
  var result = await db?.query(tableUpload, where: 'dislikes = ?', whereArgs: [1]);
  return result!;
  }

  Future<List<Map<String, dynamic>>> getAllChats() async {
    Database? db = await instance.database;
    return await db!.query('chatTable');  // 'chatTable'は適切なテーブル名に変更してください
  }

  Future<int> blockChat(int chatId) async {
    Database? db = await instance.database;
    return await db!.insert('blockListTable', {'chatId': chatId});  // 'blockListTable'というテーブル名は仮のものです。実際のテーブル名に変更してください。
  }

  Future<int> saveMessage(int chatId, String message) async {
    Database? db = await instance.database;
    return await db!.insert('messagesTable', {'chatId': chatId, 'message': message});
  }

  Future<List<Map<String, dynamic>>> getMessages(int chatId) async {
    Database? db = await instance.database;
    return await db!.query('messagesTable', where: 'chatId = ?', whereArgs: [chatId]);
  }

  // ログインユーザーのアップロードした作品の合計数を取得する
  Future<int> getUserTotalUploads(int userId) async {
    Database? db = await instance.database;
    var result = await db?.rawQuery('SELECT COUNT(*) FROM $tableUpload WHERE $columnUserId = ?', [userId]);
    return Sqflite.firstIntValue(result!) ?? 0;
  }

// ログインユーザーの作品で受け取った「いいね」の合計数を取得する
  Future<int> getUserTotalLikes(int userId) async {
    Database? db = await instance.database;
    var result = await db?.rawQuery('SELECT SUM($columnLikes) FROM $tableUpload WHERE $columnUserId = ?', [userId]);
    return Sqflite.firstIntValue(result!) ?? 0;
  }

// ログインユーザーがアップロードした全ての作品の情報を取得する
  Future<List<Map<String, dynamic>>> getUserUploads(int userId) async {
    Database? db = await instance.database;
    var result = await db?.query(tableUpload, where: '$columnUserId = ?', whereArgs: [userId]);
    return result ?? [];
  }

  // DatabaseHelperクラス内に以下のメソッドを追加
  Future<Map<String, dynamic>?> getUser(int id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(tableUser, where: '$columnId = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<Map<String, dynamic>?> getUserByUsername(String username) async {
    Database db = await instance.database;
    var res = await db.query(tableUser, where: '$columnUsername = ?', whereArgs: [username]);
    return res.isNotEmpty ? res.first : null;
  }

  // ユーザーの認証
  Future<int?> validateUser(String username, String password) async {
    Database db = await instance.database;
    var res = await db.rawQuery("SELECT id FROM userTable WHERE username = ? AND password = ?", [username, password]);
    if (res.length > 0) {
      return res.first['id'] as int;  // ユーザーIDを返す
    }
    return null;  // ユーザーが存在しない場合はnullを返す
  }

  // ユーザーの追加
  Future<int?> insertUser(String username, String password) async {
    Database db = await instance.database;
    Map<String, dynamic> row = {
      columnUsername: username,
      columnPassword: password,
    };
    return await db.insert(tableUser, row);
  }
}
