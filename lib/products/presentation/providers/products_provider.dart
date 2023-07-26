import 'package:ecommerce_ui_flutter/products/domain/repositories/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecommerce_ui_flutter/products/domain/entities/product.dart';
import 'package:ecommerce_ui_flutter/products/presentation/providers/products_repositories_provider.dart';

final productsProvider =
    StateNotifierProvider<ProductsNotifier, ProductsState>((ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return ProductsNotifier(productsRepository: productsRepository);
});

class ProductsNotifier extends StateNotifier<ProductsState> {
  final ProductRepository productsRepository;

  ProductsNotifier({required this.productsRepository})
      : super(ProductsState()) {
    loadNextPage();
  }

  Future<bool> createOrUpdateProduct(Map<String, dynamic> productLike) async {
    try {
      final product = await productsRepository.createUpdateProduct(productLike);

      final isProductInList =
          state.products.any((element) => element.id == product.id);

      if (!isProductInList) {
        state = state.copyWith(products: [...state.products, product]);
        return true;
      }

      state = state.copyWith(
          products: state.products
              .map(
                (element) => (element.id == product.id) ? product : element,
              )
              .toList());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final products = await productsRepository.getProducts(
        limit: state.limit, page: state.page);

    if (products.isEmpty) {
      state = state.copyWith(isLoading: false, isLastPage: true);
      return;
    }

    state = state.copyWith(
        isLastPage: false,
        isLoading: false,
        page: state.page + 1,
        products: [...state.products, ...products]);
  }
}

class ProductsState {
  final bool isLastPage;
  final int limit;
  final int page;
  final bool isLoading;
  final List<Product> products;

  ProductsState(
      {this.isLastPage = false,
      this.limit = 10,
      this.page = 1,
      this.isLoading = false,
      this.products = const []});

  ProductsState copyWith({
    bool? isLastPage,
    int? limit,
    int? page,
    bool? isLoading,
    List<Product>? products,
  }) =>
      ProductsState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        page: page ?? this.page,
        isLoading: isLoading ?? this.isLoading,
        products: products ?? this.products,
      );
}
