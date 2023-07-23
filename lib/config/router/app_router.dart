import 'package:ecommerce_ui_flutter/auth/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/complete_profile',
  routes: [
    GoRoute(
      path: '/login',
      // name: HomeScreen.name,
      builder: (context, state) {
        // final pageIndex = int.parse(state.pathParameters['page'] ?? '0');

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
      redirect: (_, __) => '/home/0',
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
