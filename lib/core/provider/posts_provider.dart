import 'package:flutter/material.dart';
import 'package:test_android_flutter/core/constants/constants.dart';
import 'package:test_android_flutter/core/models/post.dart';
import 'package:test_android_flutter/core/models/user.dart';
import 'package:dio/dio.dart';
import 'package:test_android_flutter/core/services/retrofit/api_client.dart';
import 'package:test_android_flutter/core/services/sqlfite/post_database_helper.dart';
import 'package:test_android_flutter/core/services/sqlfite/user_database_helper.dart';

class PostsProvider with ChangeNotifier {
  // State variables
  List<Post> _posts = [];
  List<Post> _searchPosts = [];
  List<User> _users = [];
  bool _error = false;
  bool _isLoading = false;
  DateTime? _lastUpdated;

  // Getters for state variables
  List<Post> get posts => List.unmodifiable(_posts);
  List<Post> get searchPosts => List.unmodifiable(_searchPosts);
  List<User> get users => List.unmodifiable(_users);
  bool get error => _error;
  bool get isLoading => _isLoading;
  DateTime? get lastUpdated => _lastUpdated;

  // Service dependencies
  final ApiClient _apiClient;
  final PostDatabaseHelper _postDbHelper;
  final UserDatabaseHelper _userDbHelper;

  // Constructor with dependency injection
  PostsProvider({
    ApiClient? apiClient,
    PostDatabaseHelper? postDbHelper,
    UserDatabaseHelper? userDbHelper,
  })  : _apiClient = apiClient ??
            ApiClient(
              Dio(BaseOptions(
                baseUrl: Constants.baseUrl,
                contentType: 'application/json',
                connectTimeout: const Duration(seconds: 15),
                receiveTimeout: const Duration(seconds: 15),
              )),
            ),
        _postDbHelper = postDbHelper ?? PostDatabaseHelper(),
        _userDbHelper = userDbHelper ?? UserDatabaseHelper();

  Future<void> getPosts({bool forceRefresh = false}) async {
    try {
      // Check cache validity (1 hour cache duration)
      final cacheValid = !forceRefresh && _lastUpdated != null && DateTime.now().difference(_lastUpdated!) < const Duration(hours: 1);

      if (!forceRefresh && _posts.isNotEmpty && cacheValid) return;

      // Load from cache if not forcing refresh
      if (!forceRefresh) {
        final cachedPosts = await _postDbHelper.getAllPosts();
        if (cachedPosts.isNotEmpty) {
          _posts = cachedPosts;
          _searchPosts = List.from(_posts);
          notifyListeners();
        }
      }

      // Fetch from API
      final apiPosts = await _apiClient.getPosts();

      // Update cache in a transaction
      await _postDbHelper.clearPosts();
      await Future.wait(apiPosts.map((post) => _postDbHelper.insertPost(post)));

      // Update state
      _posts = apiPosts;
      _searchPosts = List.from(_posts);
      _lastUpdated = DateTime.now();
      notifyListeners();
    } catch (e) {
      debugPrint('Posts fetch error: $e');
      if (_posts.isEmpty) {
        _error = true;
        notifyListeners();
        throw Exception('Failed to load posts: $e');
      }
    }
  }

  Future<void> getUsers({bool forceRefresh = false}) async {
    try {
      // Check cache validity
      final cacheValid = !forceRefresh && _lastUpdated != null && DateTime.now().difference(_lastUpdated!) < const Duration(hours: 1);

      if (!forceRefresh && _users.isNotEmpty && cacheValid) return;

      if (!forceRefresh) {
        final cachedUsers = await _userDbHelper.getAllUsers();
        if (cachedUsers.isNotEmpty) {
          _users = cachedUsers;
          notifyListeners();
        }
      }

      final apiUsers = await _apiClient.getUsers();

      await _userDbHelper.clearUsers();
      await Future.wait(apiUsers.map((user) => _userDbHelper.insertUser(user)));

      _users = apiUsers;
      _lastUpdated = DateTime.now();
      notifyListeners();
    } catch (e) {
      debugPrint('Users fetch error: $e');
      if (_users.isEmpty) {
        _error = true;
        notifyListeners();
        throw Exception('Failed to load users: $e');
      }
    }
  }

  Future<void> initializeData({bool forceRefresh = false}) async {
    if (_isLoading) return;

    _isLoading = true;
    _error = false;
    notifyListeners();

    try {
      await Future.wait([
        getUsers(forceRefresh: forceRefresh),
        getPosts(forceRefresh: forceRefresh),
      ]);
      _error = false;
    } catch (e) {
      _error = true;
      debugPrint('Initialization error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void filterPosts({required String filter}) {
    if (filter.isEmpty) {
      _searchPosts = List.from(_posts);
    } else {
      final lowerFilter = filter.toLowerCase();
      final matchingUser = _users.firstWhere(
        (user) => user.name?.toLowerCase().contains(lowerFilter) ?? false,
        orElse: () => User(id: -1),
      );

      _searchPosts = _posts.where((post) {
        return post.userId == matchingUser.id ||
            post.title?.toLowerCase().contains(lowerFilter) == true ||
            post.body?.toLowerCase().contains(lowerFilter) == true ||
            post.id.toString().contains(lowerFilter);
      }).toList();
    }
    notifyListeners();
  }

  // Additional helper methods
  Future<void> refreshData() => initializeData(forceRefresh: true);

  User? getUserForPost(Post post) {
    try {
      return _users.firstWhere((user) => user.id == post.userId);
    } catch (e) {
      return null;
    }
  }
}
