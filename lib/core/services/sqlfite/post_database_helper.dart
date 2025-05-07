import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PostDatabaseHelper {
  static final PostDatabaseHelper _instance = PostDatabaseHelper._internal();
  factory PostDatabaseHelper() => _instance;

  static Database? _database;
  final String tablePost = 'post';
  final String columnId = 'id';
  final String columnUserId = 'userId';
  final String columnTitle = 'title';
  final String columnBody = 'body';

  PostDatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'posts.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tablePost (
        $columnId INTEGER PRIMARY KEY,
        $columnUserId INTEGER NOT NULL,
        $columnTitle TEXT NOT NULL,
        $columnBody TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertPost(Map<String, dynamic> post) async {
    final db = await database;
    return await db.insert(tablePost, post, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getPost(int id) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      tablePost,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) return result.first;
    return null;
  }

  Future<List<Map<String, dynamic>>> getAllPosts() async {
    final db = await database;
    return await db.query(tablePost);
  }

  Future<int> updatePost(Map<String, dynamic> post) async {
    final db = await database;
    return await db.update(
      tablePost,
      post,
      where: '$columnId = ?',
      whereArgs: [post[columnId]],
    );
  }

  Future<int> deletePost(int id) async {
    final db = await database;
    return await db.delete(
      tablePost,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<void> clearPosts() async {
    final db = await database;
    await db.delete(tablePost);
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
