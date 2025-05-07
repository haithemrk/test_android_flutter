import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:test_android_flutter/core/models/user.dart';

class UserDatabaseHelper {
  static final UserDatabaseHelper _instance = UserDatabaseHelper._internal();
  factory UserDatabaseHelper() => _instance;

  static Database? _database;

  final String tableUser = 'users';
  final String userColumnId = 'id';
  final String userColumnName = 'name';
  final String userColumnUsername = 'username';
  final String userColumnEmail = 'email';
  final String userColumnPhone = 'phone';

  UserDatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableUser (
        $userColumnId INTEGER PRIMARY KEY,
        $userColumnName TEXT,
        $userColumnUsername TEXT,
        $userColumnEmail TEXT,
        $userColumnPhone TEXT
      )
    ''');
  }

  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert(
      tableUser,
      {
        userColumnId: user.id,
        userColumnName: user.name,
        userColumnUsername: user.username,
        userColumnEmail: user.email,
        userColumnPhone: user.phone,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<User?> getUser(int id) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      tableUser,
      where: '$userColumnId = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      final map = result.first;
      return User(
        id: map[userColumnId],
        name: map[userColumnName],
        username: map[userColumnUsername],
        email: map[userColumnEmail],
        phone: map[userColumnPhone],
      );
    }
    return null;
  }

  Future<List<User>> getAllUsers() async {
    final db = await database;
    final result = await db.query(tableUser);
    return result.map((map) {
      return User(
        id: map[userColumnId] as int?,
        name: map[userColumnName] as String?,
        username: map[userColumnUsername] as String?,
        email: map[userColumnEmail] as String?,
        phone: map[userColumnPhone] as String?,
      );
    }).toList();
  }

  Future<int> updateUser(User user) async {
    final db = await database;
    return await db.update(
      tableUser,
      {userColumnName: user.name, userColumnUsername: user.username, userColumnEmail: user.email, userColumnPhone: user.phone},
      where: '$userColumnId = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete(
      tableUser,
      where: '$userColumnId = ?',
      whereArgs: [id],
    );
  }

  Future<void> clearUsers() async {
    final db = await database;
    await db.delete(tableUser);
  }
}
