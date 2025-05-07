import 'package:flutter/material.dart';
import 'package:test_android_flutter/core/models/post.dart';
import 'package:test_android_flutter/core/models/user.dart';
import 'package:dio/dio.dart';
import 'package:test_android_flutter/core/services/retrofit/api_client.dart';
import 'package:test_android_flutter/core/services/sqlfite/post_database_helper.dart';
import 'package:test_android_flutter/core/services/sqlfite/user_database_helper.dart';

class PostsProvider with ChangeNotifier {
  List<Post> posts = [];
  List<Post> searchPosts = [];
  List<User> users = [];
  bool error = false;
  bool isLoading = false;

  final ApiClient apiClient = ApiClient(Dio());
  final PostDatabaseHelper dbHelperPosts = PostDatabaseHelper();
  final UserDatabaseHelper dbHelperUsers = UserDatabaseHelper();

  Future<void> getPosts() async {
    final response = await Dio().get('https://jsonplaceholder.typicode.com/posts');

    if (response.statusCode == 200) {
      posts = (response.data as List).map((json) => Post.fromJson(json)).toList();
      searchPosts = List<Post>.from(posts);
      notifyListeners();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<void> getUsers() async {
    final response = await Dio().get('https://jsonplaceholder.typicode.com/users');

    if (response.statusCode == 200) {
      users = (response.data as List).map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> initializeData() async {
    isLoading = true;
    error = false;
    notifyListeners();

    try {
      await getUsers();
      await getPosts();
      error = false;
    } catch (e) {
      error = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void filterPosts({required String filter}) {
    if (filter.isNotEmpty) {
      final lowerFilter = filter.toLowerCase();
      final matchingUser = users.firstWhere(
        (user) => user.name?.toLowerCase().contains(lowerFilter) ?? false,
        orElse: () => User(id: -1),
      );

      searchPosts = posts.where((post) {
        return post.userId == matchingUser.id ||
            post.title?.toLowerCase().contains(lowerFilter) == true ||
            post.body?.toLowerCase().contains(lowerFilter) == true ||
            post.id.toString().contains(lowerFilter);
      }).toList();
    } else {
      searchPosts = List<Post>.from(posts);
    }

    notifyListeners();
  }
}
