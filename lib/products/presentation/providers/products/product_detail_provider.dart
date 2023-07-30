import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecommerce_ui_flutter/products/domain/domain.dart';
import 'package:ecommerce_ui_flutter/products/presentation/providers/providers.dart';

final productDetailProvider =
    StateNotifierProvider<ProductDetailNotifier, Map<String, Product>>((ref) {
  final productRepository = ref.watch(productsRepositoryProvider);
  return ProductDetailNotifier(productRepository: productRepository);
});

class ProductDetailNotifier extends StateNotifier<Map<String, Product>> {
  final ProductRepository productRepository;
  ProductDetailNotifier({required this.productRepository}) : super({});

  Future<void> getSingleProduct(String productId) async {
    if (state[productId] != null) return;
    final product = await productRepository.getSingleProduct(productId);
    state = {...state, product.id: product};
  }
}

// class ProductDetailState {
//   final Map<String, Product> products;

//   ProductDetailState({this.products = const {}});

//   ProductDetailState copyWith({
//     Map<String, Product>? products,
//   }) =>
//       ProductDetailState(
//         products: products ?? this.products,
//       );
// }
