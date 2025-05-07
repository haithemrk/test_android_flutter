import 'package:go_router/go_router.dart';
import 'package:test_android_flutter/core/models/post.dart';
import 'package:test_android_flutter/core/models/user.dart';
import 'package:test_android_flutter/ui/pages/account_screen.dart';
import 'package:test_android_flutter/ui/pages/auth/login_screen.dart';
import 'package:test_android_flutter/ui/pages/auth/register_screen.dart';
import 'package:test_android_flutter/ui/pages/explore_screen.dart';
import 'package:test_android_flutter/ui/pages/home_screen.dart';
import 'package:test_android_flutter/ui/pages/main_screen.dart';
import 'package:test_android_flutter/ui/pages/post_details_screen.dart';
import 'package:test_android_flutter/ui/pages/posts_screen.dart';
import 'package:test_android_flutter/ui/pages/splash_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => MainScreen(
          navigationShell: navigationShell,
        ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                name: 'home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/posts', name: 'posts', builder: (context, state) => const PostsScreen(), routes: [
                GoRoute(
                  path: 'details',
                  name: 'details',
                  builder: (context, state) {
                    final Map<String, dynamic> data = state.extra! as Map<String, dynamic>;

                    return PostDetailsScreen(
                      post: data["post"] as Post,
                      user: data["user"] as User,
                      key: state.pageKey,
                    );
                  },
                ),
              ]),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/explore',
                name: 'explore',
                builder: (context, state) => const ExploreScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/account',
                name: 'account',
                builder: (context, state) => const AccountScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
