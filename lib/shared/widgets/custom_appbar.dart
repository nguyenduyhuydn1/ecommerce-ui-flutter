// import 'package:ecommerce_ui_flutter/products/presentation/delegates/search_product_delegates.dart';
// import 'package:ecommerce_ui_flutter/products/presentation/providers/searchs/search_product_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

// class CustomAppbar extends ConsumerWidget {
//   const CustomAppbar({super.key});

//   @override
//   Widget build(BuildContext context, ref) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: SizedBox(
//           width: double.infinity,
//           child: Row(
//             children: [
//               IconButton(
//                 onPressed: () {
//                   final searchedProduct = ref.read(searchedProvider);
//                   final searchQuery = ref.read(searchProvider);

//                   showSearch(
//                     query: searchedProduct,
//                     context: context,
//                     delegate: SearchProductDelegates(
//                       searchQuery:
//                           ref.read(searchProvider.notifier).searchProductByTerm,
//                       initialProducts: searchQuery,
//                     ),
//                   ).then((product) {
//                     if (product == null) return;
//                     // context.push('/home/0/movie/${movie.id}');
//                   });
//                 },
//                 iconSize: 30,
//                 icon: const Icon(Icons.search, color: Colors.white),
//               ),
//               IconButton(
//                 onPressed: () {
//                   context.push('/notifications');
//                 },
//                 iconSize: 30,
//                 icon: const Icon(Icons.notifications, color: Colors.white),
//               ),
//             ],
//           )),
//     );
//   }
// }
