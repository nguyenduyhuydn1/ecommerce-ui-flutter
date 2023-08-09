import 'package:ecommerce_ui_flutter/products/presentation/delegates/search_product_delegates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecommerce_ui_flutter/products/presentation/providers/providers.dart';
import 'package:ecommerce_ui_flutter/products/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(notificationsProvider.notifier).requestPermistion();
    ref.read(productsProvider.notifier).loadNextPage();
    ref.read(chanelsProvider.notifier).loadNextPage();
    ref.read(gucciProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(productsProvider);
    final chanelsState = ref.watch(chanelsProvider);
    final guccisState = ref.watch(gucciProvider);
    final size = MediaQuery.of(context).size;
    print('HomeView-------------------------------------------------------');

    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverAppBar(
          // expandedHeight: size.height * 0.3,
          floating: false,
          pinned: true,
          actions: [
            IconButton(
              onPressed: () {
                final searchedProduct = ref.read(searchedProvider);
                final searchQuery = ref.read(searchProvider);

                showSearch(
                  query: searchedProduct,
                  context: context,
                  delegate: SearchProductDelegates(
                    searchQuery:
                        ref.read(searchProvider.notifier).searchProductByTerm,
                    initialProducts: searchQuery,
                  ),
                );
              },
              iconSize: 30,
              icon: const Icon(Icons.search, color: Colors.white),
            ),
            IconButton(
              onPressed: () => context.push('/notifications'),
              iconSize: 30,
              icon: const Icon(Icons.notifications, color: Colors.white),
            ),
          ],
          title: const Text("ShipShop",
              style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: false,
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,

          // flexibleSpace: const FlexibleSpaceBar(
          //   // background: Container(
          //   //     // padding: const EdgeInsets.all(40),
          //   //     child: const Text("xxxxxxxxxxx")),
          //   title: Text("xxxxxxxxx"),
          // ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 1,
            (context, index) {
              return Column(
                children: [
                  ProductHorizontalListView(
                    title: "Recomended",
                    height: 340,
                    products: productsState.products,
                    loadNextPage:
                        ref.read(productsProvider.notifier).loadNextPage,
                  ),
                  ProductHorizontalListView(
                    widthProduct: 0.7,
                    title: "New",
                    height: 430,
                    products: chanelsState.products,
                    loadNextPage:
                        ref.read(chanelsProvider.notifier).loadNextPage,
                  ),
                  ProductHorizontalListView(
                    widthProduct: 0.7,
                    title: "Popular",
                    products: guccisState.products,
                    height: 430,
                    loadNextPage: ref.read(gucciProvider.notifier).loadNextPage,
                  ),
                  const SizedBox(height: 50)
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
