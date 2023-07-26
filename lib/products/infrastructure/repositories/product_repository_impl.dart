import 'package:ecommerce_ui_flutter/products/domain/entities/product.dart';
import 'package:ecommerce_ui_flutter/products/domain/repositories/product_repository.dart';
import 'package:ecommerce_ui_flutter/products/infrastructure/datasources/product_datasource_impl.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductDatasourceImpl datasource;
  ProductRepositoryImpl(this.datasource);

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> product) {
    return datasource.createUpdateProduct(product);
  }

  @override
  Future<List<Product>> getProducts({int page = 1, int limit = 10}) {
    return datasource.getProducts(page: page, limit: limit);
  }

  @override
  Future<Product> getSingleProduct(String id) {
    return datasource.getSingleProduct(id);
  }

  @override
  Future<List<Product>> searchProductByTerm(String term) {
    return datasource.searchProductByTerm(term);
  }
}
