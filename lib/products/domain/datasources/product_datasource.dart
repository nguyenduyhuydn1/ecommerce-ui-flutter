import 'package:ecommerce_ui_flutter/products/domain/entities/product.dart';

abstract class ProductDatasource {
  Future<List<Product>> getProducts({int page = 1, int limit = 10});
  Future<Product> getSingleProduct(String id);
  Future<List<Product>> searchProductByTerm(String term);
  Future<Product> createUpdateProduct(Map<String, dynamic> product);
}
