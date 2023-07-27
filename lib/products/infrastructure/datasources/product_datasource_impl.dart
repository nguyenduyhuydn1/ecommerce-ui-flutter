import 'package:dio/dio.dart';
import 'package:ecommerce_ui_flutter/config/constants/enviroments.dart';
import 'package:ecommerce_ui_flutter/products/domain/datasources/product_datasource.dart';
import 'package:ecommerce_ui_flutter/products/domain/entities/product.dart';
import 'package:ecommerce_ui_flutter/products/infrastructure/mappers/product_mapper.dart';

class ProductDatasourceImpl extends ProductDatasource {
  late final Dio dio;
  final String accessToken;
  ProductDatasourceImpl({
    required this.accessToken,
  }) : dio = Dio(
          BaseOptions(
              baseUrl: Environment.apiUrl,
              headers: {'Authorization': 'Bearer $accessToken'}),
        );

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> product) {
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProducts({int page = 1, int limit = 10}) async {
    final res = await dio.get('/products?limit=$limit&page=$page');
    final List<Product> products = [];

    for (final product in res.data["products"]) {
      products.add(ProductMapper.jsonToEntity(product));
    }
    return products;
  }

  @override
  Future<Product> getSingleProduct(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> searchProductByTerm(String query) async {
    final res = await dio.get(
      '/products',
      queryParameters: {'name': query},
    );
    final List<Product> products = [];

    for (final product in res.data["products"]) {
      products.add(ProductMapper.jsonToEntity(product));
    }
    return products;
  }
}
