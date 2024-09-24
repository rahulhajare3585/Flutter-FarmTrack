import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  DatabaseHelper.internal();

  // Initialize the database
  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'users.db');

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  // Create table when the database is first created
  void _onCreate(Database db, int newVersion) async {
    await db.execute(
      '''
      CREATE TABLE User(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL
      )
      ''',
    );
  }

  // Function to register a new user in the database
  Future<int> insertUser(String name, String email, String password) async {
    var dbClient = await db;
    var result = await dbClient.insert("User", {
      "name": name,
      "email": email,
      "password": password,
    });
    return result;
  }

  // Function to check if a user already exists based on email
  Future<bool> checkUserExists(String email) async {
    var dbClient = await db;
    var result = await dbClient.query(
      "User",
      where: "email = ?",
      whereArgs: [email],
    );
    return result.isNotEmpty;
  }

  // Function to validate user login
  Future<bool> validateUser(String email, String password) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
      "SELECT * FROM User WHERE email = ? AND password = ?",
      [email, password],
    );
    return result.isNotEmpty;
  }
}
