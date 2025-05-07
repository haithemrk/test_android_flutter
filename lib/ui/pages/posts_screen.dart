import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_android_flutter/core/provider/posts_provider.dart';
import 'package:test_android_flutter/ui/widgets/post_item_widget.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PostsProvider>(
      builder: (context, provider, child) {
        return ListView.builder(
          padding: EdgeInsetsDirectional.all(16),
          itemCount: provider.searchPosts.length,
          itemBuilder: (context, index) {
            return PostItemWidget(
                post: provider.searchPosts[index],
                user: provider.users.singleWhere(
                  (element) => element.id == provider.searchPosts[index].id,
                ));
          },
        );
      },
    );

    // return FutureProvider<PostsProvider>.value(
    //     value: context.read<PostsProvider>().getPosts(),
    //     builder: (context, child) {
    //       return Consumer2<List<User>, Post>(
    //         builder: (context, users, post, child) {
    //         },
    //       );
    //     });
  }
}
