import 'package:ecommerce_ui_flutter/products/presentation/delegates/search_product_delegates.dart';
import 'package:ecommerce_ui_flutter/products/presentation/providers/searchs/search_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                const Text(
                  "ShipShop",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    final searchedProduct = ref.read(searchedProvider);
                    final searchQuery = ref.read(searchProvider);

                    showSearch(
                      query: searchedProduct,
                      context: context,
                      delegate: SearchProductDelegates(
                        searchQuery: ref
                            .read(searchProvider.notifier)
                            .searchProductByTerm,
                        initialProducts: searchQuery,
                      ),
                    ).then((product) {
                      if (product == null) return;
                      // context.push('/home/0/movie/${movie.id}');
                    });
                  },
                  iconSize: 30,
                  icon: const Icon(Icons.search, color: Colors.white),
                ),
                const IconButton(
                  onPressed: null,
                  iconSize: 30,
                  icon: Icon(Icons.notifications, color: Colors.white),
                ),
              ],
            )),
      ),
    );
  }
}
