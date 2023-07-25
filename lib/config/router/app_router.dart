import 'package:ecommerce_ui_flutter/auth/presentation/screens/check_auth_status_screen.dart';
import 'package:go_router/go_router.dart';

import 'package:ecommerce_ui_flutter/auth/presentation/screens/screens.dart';
import 'package:ecommerce_ui_flutter/products/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) {
        return const CheckAuthStatusScreen();
      },
    ),
    GoRoute(
      path: '/login',
      // name: HomeScreen.name,
      builder: (context, state) {
        return const LoginScreen();
      },
      // routes: [
      //   GoRoute(
      //     path: 'movie/:id',
      //     name: MovieScreen.name,
      //     builder: (context, state) {
      //       final movieId = state.pathParameters['id'] ?? 'no-id';

      //       return MovieScreen(movieId: movieId);
      //     },
      //   ),
      // ],
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) {
        return const RegisterScreen();
      },
    ),
    GoRoute(
      path: '/complete_profile',
      builder: (context, state) {
        return const CompleteProfileScreen();
      },
    ),
    GoRoute(
      path: '/',
      builder: (context, state) {
        // final pageIndex = int.parse(state.pathParameters['page'] ?? '0');
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: '/',
      redirect: (_, __) => '/',
    ),
  ],
);

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
