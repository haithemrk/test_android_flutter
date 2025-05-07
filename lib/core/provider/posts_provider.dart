import 'package:flutter/material.dart';
import 'package:test_android_flutter/core/models/post.dart';
import 'package:test_android_flutter/core/models/user.dart';

class PostsProvider with ChangeNotifier {
  List<Post> posts = [
    Post(
      id: 1,
      userId: 1,
      body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto",
      title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    ),
    Post(
      id: 1,
      userId: 1,
      body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto",
      title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    ),
    Post(
      id: 1,
      userId: 1,
      body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto",
      title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    ),
    Post(
      id: 1,
      userId: 1,
      body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto",
      title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    ),
    Post(
      id: 1,
      userId: 1,
      body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto",
      title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    ),
    Post(
      id: 1,
      userId: 1,
      body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto",
      title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    ),
  ];
  List<Post> searchPosts = [
    Post(
      id: 1,
      userId: 1,
      body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto",
      title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    ),
    Post(
      id: 1,
      userId: 1,
      body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto",
      title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    ),
    Post(
      id: 1,
      userId: 1,
      body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto",
      title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    ),
    Post(
      id: 1,
      userId: 1,
      body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto",
      title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    ),
    Post(
      id: 1,
      userId: 1,
      body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto",
      title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    ),
    Post(
      id: 1,
      userId: 1,
      body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto",
      title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    ),
  ];
  final List<User> users = [
    User(id: 1, name: "Leanne Graham"),
    User(id: 1, name: "Leanne Graham"),
    User(id: 1, name: "Leanne Graham"),
    User(id: 1, name: "Leanne Graham"),
  ];

  Future<void> getPosts() async {}

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
