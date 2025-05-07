import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_android_flutter/core/models/user.dart';
import 'package:test_android_flutter/core/provider/posts_provider.dart';
import 'package:test_android_flutter/ui/widgets/error_widget.dart';
import 'package:test_android_flutter/ui/widgets/post_item_widget.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PostsProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.error) {
          return ServerErrorWidget();
        }

        if (provider.searchPosts.isEmpty) {
          return const Center(child: Text('No posts found.'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: provider.searchPosts.length,
          itemBuilder: (context, index) {
            final post = provider.searchPosts[index];
            final user = provider.users.firstWhere(
              (element) => element.id == post.userId,
              orElse: () => User(),
            );

            return PostItemWidget(post: post, user: user);
          },
        );
      },
    );
  }
}
