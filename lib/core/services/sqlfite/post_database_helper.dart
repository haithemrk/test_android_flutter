import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:test_android_flutter/core/models/post.dart';

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

  Future<int> insertPost(Post post) async {
    final db = await database;
    return await db.insert(
      tablePost,
      post.toJson(), // Convert Post to Map
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Post?> getPost(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      tablePost,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return Post.fromJson(result.first); // Convert Map to Post
    }
    return null;
  }

  Future<List<Post>> getAllPosts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tablePost);
    return List.generate(maps.length, (i) {
      return Post.fromJson(maps[i]); // Convert each Map to Post
    });
  }

  Future<int> updatePost(Post post) async {
    final db = await database;
    return await db.update(
      tablePost,
      post.toJson(), // Convert Post to Map
      where: '$columnId = ?',
      whereArgs: [post.id],
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
