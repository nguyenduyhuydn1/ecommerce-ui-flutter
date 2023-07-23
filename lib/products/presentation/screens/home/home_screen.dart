import 'package:flutter/material.dart';

import 'package:ecommerce_ui_flutter/shared/shared.dart';
import 'package:ecommerce_ui_flutter/products/presentation/views/views.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;
  final List<IconData> icons = const [
    Icons.home,
    Icons.favorite_outline,
    Icons.shopping_cart_outlined,
    Icons.person_2_rounded,
  ];

  final List<Widget> viewRoutes = const [
    HomeView(),
    FavoritesView(),
    CartsView(),
    ProfileView()
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: icons.length,
      child: Scaffold(
        body: IndexedStack(
          index: pageIndex,
          children: viewRoutes,
        ),
        bottomNavigationBar: CustomBottomNavigation(
          icons: icons,
          pageIndex: pageIndex,
          onPressed: (index) => setState(() => pageIndex = index),
        ),
      ),
    );
  }
}
