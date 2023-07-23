import 'package:flutter/material.dart';

import 'package:ecommerce_ui_flutter/products/presentation/widgets/widgets.dart';
import 'package:ecommerce_ui_flutter/shared/shared.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
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
              return const Column(
                children: [
                  ProductHorizontalListView(
                    title: "Recomended",
                    height: 280,
                  ),
                  ProductHorizontalListView(
                    widthProduct: 0.7,
                    title: "Recomended",
                    height: 380,
                  ),
                  ProductHorizontalListView(
                    widthProduct: 0.7,
                    title: "Recomended",
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
