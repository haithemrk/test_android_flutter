import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_android_flutter/core/models/user.dart';
import 'package:test_android_flutter/core/provider/posts_provider.dart';
import 'package:test_android_flutter/ui/pages/post_details_screen.dart';
import 'package:test_android_flutter/ui/widgets/error_widget.dart';
import 'package:test_android_flutter/ui/widgets/post_item_widget.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _initializeData() async {
    final provider = context.read<PostsProvider>();
    if (provider.posts.isEmpty && !provider.isLoading) {
      await provider.initializeData(forceRefresh: true);
    }
  }

  Future<void> _scrollListener() async {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      await _loadMoreData();
    }
  }

  Future<void> _loadMoreData() async {
    if (_isLoadingMore) return;

    setState(() => _isLoadingMore = true);
    try {
      await context.read<PostsProvider>().getPosts();
    } finally {
      if (mounted) {
        setState(() => _isLoadingMore = false);
      }
    }
  }

  Future<void> _refreshData() async {
    await context.read<PostsProvider>().initializeData(forceRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostsProvider>(builder: (context, provider, child) {
      return _buildContent(provider);
    });
  }

  Widget _buildContent(PostsProvider provider) {
    if (provider.isLoading && provider.posts.isEmpty) {
      return const LoadingShimmer(itemCount: 10);
    }

    if (provider.error && provider.posts.isEmpty) {
      return ServerErrorWidget();
    }

    if (provider.searchPosts.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.post_add,
        message: 'No posts found',
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshData,
      child: ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: provider.searchPosts.length + (_isLoadingMore ? 1 : 0),
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          if (index >= provider.searchPosts.length) {
            return const Center(child: CircularProgressIndicator());
          }

          final post = provider.searchPosts[index];
          final user = provider.getUserForPost(post) ?? User();

          return PostItemWidget(
            key: ValueKey(post.id), // Important for performance
            post: post,
            user: user,
          );
        },
      ),
    );
  }
}

class PostsSearchDelegate extends SearchDelegate {
  final PostsProvider postsProvider;

  PostsSearchDelegate({required this.postsProvider});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    postsProvider.filterPosts(filter: query);
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    postsProvider.filterPosts(filter: query);
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    return Consumer<PostsProvider>(
      builder: (context, provider, child) {
        if (provider.searchPosts.isEmpty) {
          return const Center(child: Text('No matching posts found'));
        }

        return ListView.builder(
          itemCount: provider.searchPosts.length,
          itemBuilder: (context, index) {
            final post = provider.searchPosts[index];
            final user = provider.getUserForPost(post) ?? User();
            return ListTile(
              title: Text(post.title ?? ''),
              subtitle: Text(user.name ?? ''),
              onTap: () {
                close(context, null);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostDetailsScreen(post: post, user: user),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class LoadingShimmer extends StatelessWidget {
  final int itemCount;

  const LoadingShimmer({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 20,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 8),
              Container(
                width: 150,
                height: 16,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 60,
                color: Colors.grey[300],
              ),
            ],
          ),
        );
      },
    );
  }
}

class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String message;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
