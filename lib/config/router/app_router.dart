import 'package:ecommerce_ui_flutter/auth/presentation/providers/auth_provider.dart';
import 'package:ecommerce_ui_flutter/auth/presentation/screens/check_auth_status_screen.dart';
import 'package:ecommerce_ui_flutter/config/router/app_router_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ecommerce_ui_flutter/auth/presentation/screens/screens.dart';
import 'package:ecommerce_ui_flutter/products/presentation/screens/screens.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) {
          return const CheckAuthStatusScreen();
        },
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) {
          return const RegisterScreen();
        },
      ),
      // GoRoute(
      //   path: '/complete_profile',
      //   builder: (context, state) {
      //     return const CompleteProfileScreen();
      //   },
      // ),
      GoRoute(
        path: '/profile',
        builder: (context, state) {
          return const ProfileScreen();
        },
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) {
          return const NotificationsScreen();
        },
      ),
      // GoRoute(
      //   path: '/new_card',
      //   builder: (context, state) {
      //     return const CreditCardScreen();
      //   },
      // ),
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const HomeScreen();
        },
        routes: [
          GoRoute(
            path: 'product/:id',
            builder: (context, state) {
              final productId = state.pathParameters['id'] ?? 'no-id';

              return ProductScreen(
                productId: productId,
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: '/',
        redirect: (_, __) => '/',
      ),
    ],
    redirect: (context, state) {
      final isGoingTo = state.fullPath;
      print(isGoingTo);
      final authStatus = goRouterNotifier.authStatus;

      if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) {
        return null;
      }

      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/register') return null;

        return '/login';
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == '/splash') {
          return '/';
        }
      }

      return null;
    },
  );
});

// final appRouter = GoRouter(
//   initialLocation: '/',
//   routes: [
//     ShellRoute(
//       builder: (context, state, child) => HomeScreen(childView: child),
//       routes: [
//         GoRoute(
//           path: '/',
//           name: HomeScreen.name,
//           builder: (context, state) => const HomeView(),
//           routes: [
//             GoRoute(
//               path: 'movie/:id',
//               name: MovieScreen.name,
//               builder: (context, state) {
//                 final movieId = state.pathParameters['id'] ?? 'no-id';
//                 return MovieScreen(movieId: movieId);
//               },
//             ),
//           ],
//         ),
//         GoRoute(
//           path: '/favorites',
//           name: FavoritesView.name,
//           builder: (context, state) {
//             return const FavoritesView();
//           },
//         ),
//         GoRoute(
//           path: '/categories',
//           name: CategoriesView.name,
//           builder: (context, state) {
//             return const CategoriesView();
//           },
//         ),
//       ],
//     ),
//   ],
// );
