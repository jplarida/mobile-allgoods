import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbService {
  static final DbService _instance = DbService._internal();
  static Database? _database;

  DbService._internal();

  factory DbService() => _instance;

  // Database initialization
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, 'multi_tenant_app.db'),
      onCreate: _onCreate,
      version: 1,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL UNIQUE,
        pin TEXT NOT NULL,
        role TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE tenants (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT,
        type TEXT
      )
    ''');
  }

  // User Operations
  Future<int> addUser(String username, String pin, String role) async {
    final db = await database;
    return await db.insert('users', {'username': username, 'pin': pin, 'role': role});
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query('users');
  }

  Future<Map<String, dynamic>?> getUser(String username, String pin) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'username = ? AND pin = ?',
      whereArgs: [username, pin],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Tenant Operations
  Future<int> addTenant(String name, String description, String type) async {
    final db = await database;
    return await db.insert('tenants', {'name': name, 'description': description, 'type': type});
  }

  Future<List<Map<String, dynamic>>> getTenants() async {
    final db = await database;
    return await db.query('tenants');
  }

  Future<void> clearTable(String tableName) async {
    final db = await database;
    await db.delete(tableName);
  }
}
