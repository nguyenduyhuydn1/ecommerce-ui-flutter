import 'dart:convert';

import 'package:ecommerce_ui_flutter/products/domain/entities/product.dart';
import 'package:ecommerce_ui_flutter/products/infrastructure/mappers/product_mapper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecommerce_ui_flutter/shared/infrastructure/services/key_value_storage_service_impl.dart';

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Product>>((ref) {
  final keyValueStorageService = KeyValueStorageServiceImpl();
  return FavoritesNotifier(keyValueStorageService: keyValueStorageService);
});

class FavoritesNotifier extends StateNotifier<List<Product>> {
  final KeyValueStorageServiceImpl keyValueStorageService;

  FavoritesNotifier({required this.keyValueStorageService}) : super([]);

  Future<void> _entitiesToString(List<Product> products) async {
    if (products.isEmpty) {
      keyValueStorageService.removeKey('favorites');
      return;
    }

    final entityToJson = products.map((e) => e.toJson()).toList();
    final String encode = jsonEncode(entityToJson);

    await keyValueStorageService.setKeyValue('favorites', encode);
  }

  Future<void> toggleFavorite(Product product) async {
    final checkExists = state.indexWhere((e) => e.id == product.id);
    if (checkExists == -1) {
      state = [...state, product];
    } else {
      state = state.where((e) => e.id != product.id).toList();
    }
    await _entitiesToString(state);
  }

  Future<void> getDataFavorites() async {
    final bool checkKey =
        await keyValueStorageService.checkKeyExists('favorites');
    if (!checkKey) {
      final String encode = jsonEncode([]);
      await keyValueStorageService.setKeyValue('favorites', encode);
      return;
    }

    final favorites =
        await keyValueStorageService.getValue<String>('favorites');
    final decode = jsonDecode(favorites!);
    final List<Product> products = [];
    for (final x in decode) {
      products.add(ProductMapper.jsonToEntity(x));
    }

    state = products;
  }

  Future<void> setDataFavorites(Product product) async {
    final checkExists = state.indexWhere((e) => e.id == product.id);
    if (checkExists == -1) return;

    state = [...state, product];
    await _entitiesToString(state);
  }

  Future<void> removeDataFavorites(String productId) async {
    state = state.where((e) => e.id != productId).toList();

    await _entitiesToString(state);
    // var list = products.map((e) => e.toJson()).toList();
    // var xx = jsonEncode(list);
    // List<dynamic> xcz = jsonDecode(xx);
    // List<dynamic> ddddddddd =
    //     xcz.map((e) => ProductMapper.jsonToEntity(e)).toList();

    // print(ddddddddd[0].id);
  }
}

// final favoritesProvider =
//     StateNotifierProvider<FavoritesNotifier, Map<String, Product>>((ref) {
//   final keyValueStorageService = KeyValueStorageServiceImpl();
//   return FavoritesNotifier(keyValueStorageService: keyValueStorageService);
// });

// class FavoritesNotifier extends StateNotifier<Map<String, Product>> {
//   final KeyValueStorageServiceImpl keyValueStorageService;

//   FavoritesNotifier({required this.keyValueStorageService}) : super({});

//   Future<void> _entitiesToString(List<Product> products) async {
//     final entityToJson = products.map((e) => e.toJson()).toList();
//     final String encode = jsonEncode(entityToJson);

//     await keyValueStorageService.setKeyValue('favorites', encode);
//   }

//   Future<void> toggleFavorite(Product product) async {
//     if (state[product.id] != null) {
//       state = {...state, product.id: product};
//     } else {
//       state.removeWhere((key, value) => key == product.id);
//     }

//     // final checkExists = state.indexWhere((e) => e.id == product.id);
//     // if (checkExists == -1) {
//     //   state = [...state, product];
//     // } else {
//     //   state = state.where((e) => e.id == product.id).toList();
//     // }
//     // await _entitiesToString(state);
//   }

//   Future<void> getDataFavorites() async {
//     final bool checkKey =
//         await keyValueStorageService.checkKeyExists('favorites');

//     if (!checkKey) {
//       final String encode = jsonEncode({});
//       await keyValueStorageService.setKeyValue('favorites', encode);
//       return;
//     }

//     final String favorites = await keyValueStorageService.getValue('favorites');
//     final decocde = jsonDecode(favorites);
//     List<Product> products =
//         decocde.map((e) => ProductMapper.jsonToEntity(e)).toList();
//     state = products;
//   }

//   Future<void> setDataFavorites(Product product) async {
//     final checkExists = state.indexWhere((e) => e.id == product.id);
//     if (checkExists == -1) return;

//     state = [...state, product];
//     await _entitiesToString(state);
//   }

//   Future<void> removeDataFavorites(String productId) async {
//     state = state.where((e) => e.id != productId).toList();

//     await _entitiesToString(state);
//     // var list = products.map((e) => e.toJson()).toList();
//     // var xx = jsonEncode(list);
//     // List<dynamic> xcz = jsonDecode(xx);
//     // List<dynamic> ddddddddd =
//     //     xcz.map((e) => ProductMapper.jsonToEntity(e)).toList();

//     // print(ddddddddd[0].id);
//   }
// }
