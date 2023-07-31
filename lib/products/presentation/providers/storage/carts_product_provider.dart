import 'dart:convert';

import 'package:ecommerce_ui_flutter/products/domain/entities/product.dart';
import 'package:ecommerce_ui_flutter/products/infrastructure/mappers/product_mapper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecommerce_ui_flutter/shared/infrastructure/services/key_value_storage_service_impl.dart';

final cartsProvider =
    StateNotifierProvider<CartsNotifier, List<Product>>((ref) {
  final keyValueStorageService = KeyValueStorageServiceImpl();
  return CartsNotifier(keyValueStorageService: keyValueStorageService);
});

class CartsNotifier extends StateNotifier<List<Product>> {
  final KeyValueStorageServiceImpl keyValueStorageService;

  CartsNotifier({required this.keyValueStorageService}) : super([]);

  Future<void> _entitiesToString(List<Product> products) async {
    if (products.isEmpty) {
      keyValueStorageService.removeKey('carts');
      return;
    }
    final entityToJson = products.map((e) => e.toJson()).toList();
    final String encode = jsonEncode(entityToJson);

    await keyValueStorageService.setKeyValue('carts', encode);
  }

  Future<void> getDataCarts() async {
    final bool checkKey = await keyValueStorageService.checkKeyExists('carts');
    if (!checkKey) return;

    final carts = await keyValueStorageService.getValue<String>('carts');
    final decode = jsonDecode(carts!);
    final List<Product> products = [];
    for (final x in decode) {
      products.add(ProductMapper.jsonToEntity(x));
    }

    state = products;
  }

  Future<void> addToCarts(Product product) async {
    final checkExists = state.indexWhere((e) => e.id == product.id);
    if (checkExists == -1) {
      product.qty = 1;
      state = [...state, product];
    } else {
      final temp = state.map((e) {
        if (e.id == product.id) e.qty = e.qty! + 1;
        return e;
      });
      state = [...temp];
    }
    await _entitiesToString(state);
  }

  Future<void> removeDataCarts(String productId) async {
    state = state.where((e) => e.id != productId).toList();
    await _entitiesToString(state);
  }

  Future<void> addAndMinusCarts(String productId, int value) async {
    final temp = state.map((e) {
      if (e.id == productId) e.qty = e.qty! + value;
      if (e.qty! <= 0) return null;
      return e;
    }).toList();

    final List<Product> products = [];
    for (final x in temp) {
      if (x != null) products.add(x);
    }

    state = products;
    await _entitiesToString(state);
  }
}
