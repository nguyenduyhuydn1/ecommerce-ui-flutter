import 'package:ecommerce_ui_flutter/products/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts({int page = 1, int limit = 10});
  Future<List<Product>> getChanels({int page = 1, int limit = 10});
  Future<List<Product>> getGuccis({int page = 1, int limit = 10});

  Future<Product> getSingleProduct(String id);
  Future<List<Product>> searchProductByTerm(String query);
  Future<Product> createUpdateProduct(Map<String, dynamic> product);
}
