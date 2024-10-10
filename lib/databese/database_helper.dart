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

  // Initialize the database with version 3 to include the CentringPlates table
  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'users.db');

    var db = await openDatabase(path,
        version: 3, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return db;
  }

  // Create tables when the database is first created
  void _onCreate(Database db, int version) async {
    // Create User table
    await db.execute('''
      CREATE TABLE User(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        contact TEXT NOT NULL
      )
      ''');

    // Create Customer table
    await db.execute('''
      CREATE TABLE Customer(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        address TEXT NOT NULL,
        contact TEXT NOT NULL,
        aadhar TEXT
      )
      ''');

    // Create CentringPlates table with a foreign key reference to the Customer table
    await db.execute('''
      CREATE TABLE CentringPlates(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        customer_id INTEGER,
        plates_quantity INTEGER,
        rate REAL,
        total_amount REAL,
        received_amount REAL,
        pending_amount REAL,
        total_days INTEGER,
        given_date TEXT,
        received_date TEXT,
        FOREIGN KEY (customer_id) REFERENCES Customer(id) ON DELETE CASCADE
      )
      ''');
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

  // Upgrade the database to add new tables if needed
  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Create Customer table if upgrading from version 1
      await db.execute('''
        CREATE TABLE Customer(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          address TEXT NOT NULL,
          contact TEXT NOT NULL,
          aadhar TEXT
        )
        ''');
    }
    if (oldVersion < 3) {
      // Create CentringPlates table if upgrading from version 2
      await db.execute('''
        CREATE TABLE CentringPlates(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          customer_id INTEGER,
          plates_quantity INTEGER,
          rate REAL,
          total_amount REAL,
          received_amount REAL,
          pending_amount REAL,
          total_days INTEGER,
          given_date TEXT,
          received_date TEXT,
          FOREIGN KEY (customer_id) REFERENCES Customer(id) ON DELETE CASCADE
        )
        ''');
    }
  }

  // Function to register a new user in the database
  Future<int> insertUser(
      String name, String email, String password, String contact) async {
    var dbClient = await db;
    var result = await dbClient.insert("User", {
      "name": name,
      "email": email,
      "password": password,
      "contact": contact
    });
    return result;
  }

  // Function to register a new customer in the database
  Future<int> insertCustomer(
      String name, String address, String contact, String? aadhar) async {
    var dbClient = await db;
    var result = await dbClient.insert("Customer", {
      "name": name,
      "address": address,
      "contact": contact,
      "aadhar": aadhar
    });
    return result;
  }

  // Function to insert centring plate details
  Future<int> insertCentringPlateDetails({
    required int customerId,
    required int platesQuantity,
    required double rate,
    required double totalAmount,
    required double receivedAmount,
    required double pendingAmount,
    required int totalDays,
    required String givenDate,
    required String receivedDate,
  }) async {
    var dbClient = await db;
    var result = await dbClient.insert("CentringPlates", {
      "customer_id": customerId,
      "plates_quantity": platesQuantity,
      "rate": rate,
      "total_amount": totalAmount,
      "received_amount": receivedAmount,
      "pending_amount": pendingAmount,
      "total_days": totalDays,
      "given_date": givenDate,
      "received_date": receivedDate,
    });
    return result;
  }

  // Function to check if a customer already exists based on contact
  Future<bool> checkCustomerExists(String contact) async {
    final dbClient = await db;

    final result = await dbClient.query(
      "Customer",
      where: "contact = ?",
      whereArgs: [contact],
      limit: 1, // Optimization to stop searching after finding the first match
    );

    // Return true if customer exists, false otherwise
    return result.isNotEmpty;
  }

  // Function to get all customer details
  Future<List<Map<String, dynamic>>> getCustomers() async {
    var dbClient = await db;
    var result = await dbClient.query("Customer");
    return result;
  }

  // Function to get all customer details along with plates quantity and pending amount
  Future<List<Map<String, dynamic>>> getPlatesCustomers() async {
    var dbClient = await db;

    // SQL query to join the Customer and CentringPlates tables
    var result = await dbClient.rawQuery('''
    SELECT Customer.name, Customer.contact, 
           IFNULL(SUM(CentringPlates.plates_quantity), 0) AS platesQuantity, 
           IFNULL(SUM(CentringPlates.pending_amount), 0) AS pendingAmount
    FROM Customer
    LEFT JOIN CentringPlates ON Customer.id = CentringPlates.customer_id
    GROUP BY Customer.id
  ''');

    return result;
  }
}
