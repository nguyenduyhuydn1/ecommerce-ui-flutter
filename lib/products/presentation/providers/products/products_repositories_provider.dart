import 'package:ecommerce_ui_flutter/auth/presentation/providers/auth_provider.dart';
import 'package:ecommerce_ui_flutter/products/domain/repositories/product_repository.dart';
import 'package:ecommerce_ui_flutter/products/infrastructure/datasources/product_datasource_impl.dart';
import 'package:ecommerce_ui_flutter/products/infrastructure/repositories/product_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsRepositoryProvider = Provider<ProductRepository>((ref) {
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final productsRepository =
      ProductRepositoryImpl(ProductDatasourceImpl(accessToken: accessToken));

  return productsRepository;
});
