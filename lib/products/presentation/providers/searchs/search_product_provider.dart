import 'package:ecommerce_ui_flutter/products/presentation/providers/products_repositories_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecommerce_ui_flutter/products/domain/domain.dart';

final searchedProvider = StateProvider<String>((ref) => "");

final searchProvider =
    StateNotifierProvider<SearchProductNotifier, List<Product>>((ref) {
  final productsRepository =
      ref.watch(productsRepositoryProvider).searchProductByTerm;
  return SearchProductNotifier(searchProduct: productsRepository, ref: ref);
});

class SearchProductNotifier extends StateNotifier<List<Product>> {
  final Future<List<Product>> Function(String) searchProduct;
  final Ref ref;

  SearchProductNotifier({required this.searchProduct, required this.ref})
      : super([]);

  Future<List<Product>> searchProductByTerm(String query) async {
    if (query.isEmpty) return [];

    final List<Product> products = await searchProduct(query);
    ref.read(searchedProvider.notifier).update((state) => query);
    state = products;

    return products;
  }
}




// class ProductState {
//   final bool isLastPage;
//   final int limit;
//   final int page;
//   final bool isLoading;
//   final List<Product> product;

//   ProductState(
//       {this.isLastPage = false,
//       this.limit = 10,
//       this.page = 1,
//       this.isLoading = false,
//       this.product = const []});

//   ProductState copyWith({
//     bool? isLastPage,
//     int? limit,
//     int? page,
//     bool? isLoading,
//     List<Product>? product,
//   }) =>
//       ProductState(
//         isLastPage: isLastPage ?? this.isLastPage,
//         limit: limit ?? this.limit,
//         page: page ?? this.page,
//         isLoading: isLoading ?? this.isLoading,
//         product: product ?? this.product,
//       );
// }
