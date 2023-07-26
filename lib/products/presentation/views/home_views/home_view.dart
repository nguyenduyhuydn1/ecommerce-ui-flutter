import 'package:ecommerce_ui_flutter/products/presentation/providers/products_provider.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_ui_flutter/products/presentation/widgets/widgets.dart';
import 'package:ecommerce_ui_flutter/shared/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(productsProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(productsProvider);

    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
            centerTitle: true,
          ),
          backgroundColor: Colors.green,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 1,
            (context, index) {
              return Column(
                children: [
                  ProductHorizontalListView(
                    title: "Recomended",
                    height: 280,
                    products: productsState.products,
                  ),
                  ProductHorizontalListView(
                    widthProduct: 0.7,
                    title: "Recomended",
                    height: 380,
                    products: productsState.products,
                  ),
                  ProductHorizontalListView(
                    widthProduct: 0.7,
                    title: "Recomended",
                    products: productsState.products,
                    height: 380,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
