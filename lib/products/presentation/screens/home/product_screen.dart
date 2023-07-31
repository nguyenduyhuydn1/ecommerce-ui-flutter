import 'package:ecommerce_ui_flutter/products/presentation/providers/storage/carts_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:ecommerce_ui_flutter/products/domain/domain.dart';
import 'package:ecommerce_ui_flutter/products/presentation/providers/providers.dart';
import 'package:ecommerce_ui_flutter/products/presentation/views/custom_shimmer.dart';

class ProductScreen extends ConsumerStatefulWidget {
  final String productId;
  const ProductScreen({super.key, required this.productId});

  @override
  ProductScreenState createState() => ProductScreenState();
}

class ProductScreenState extends ConsumerState<ProductScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(productDetailProvider.notifier).getSingleProduct(widget.productId);
  }

  int count = 0;
  bool seeMore = true;

  @override
  Widget build(BuildContext context) {
    final Product? product = ref.watch(productDetailProvider)[widget.productId];
    final favorites = ref.watch(favoritesProvider);
    final checkFavorite = favorites.indexWhere((e) => e.id == widget.productId);

    final size = MediaQuery.of(context).size;

    if (product == null) return _ShimmerDetail(size: size);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () async {
                await ref.read(cartsProvider.notifier).addToCarts(product);
              },
              icon: const Icon(Icons.shopping_cart_sharp),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () async {
                await ref
                    .read(favoritesProvider.notifier)
                    .toggleFavorite(product);
              },
              icon: checkFavorite != -1
                  ? const Icon(
                      Icons.favorite_outlined,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.favorite_outline,
                    ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    product.images[count],
                    width: size.width * 0.7,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              listImages(product, size),
              const SizedBox(height: 20),
              _SizeSelector(
                selectedSizes: product.sizes,
                onSizesChanged: (selectedSizes) {},
              ),
              const SizedBox(height: 20),
              descriptionProduct(product),
              const SizedBox(height: 200),
            ],
          ),
        ),
      ),
    );
  }

  Container descriptionProduct(Product product) {
    var price =
        NumberFormat.simpleCurrency(decimalDigits: 0).format(product.price);
    return Container(
      color: const Color.fromARGB(255, 235, 233, 233),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.name,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              price,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.description,
              style: const TextStyle(fontSize: 15),
              maxLines: seeMore ? 8 : null,
              overflow: seeMore ? TextOverflow.ellipsis : null,
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                seeMore = !seeMore;
              });
            },
            child: seeMore
                ? const Text(
                    "See More ...",
                    style: TextStyle(fontSize: 17),
                  )
                : const Text(
                    "See Less",
                    style: TextStyle(fontSize: 17),
                  ),
          ),
          // Directionality(
          //   textDirection: TextDirection.rtl,
          //   child: TextButton.icon(
          //     onPressed: () {
          //       setState(() {
          //         seeMore = !seeMore;
          //       });
          //     },
          //     icon: const Icon(
          //       Icons.arrow_back_ios,
          //       size: 15,
          //     ),
          //     label: seeMore
          //         ? const Text("See More")
          //         : const Text("See Less"),
          //   ),
          // ),
        ],
      ),
    );
  }

  SizedBox listImages(Product product, Size size) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: product.images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                count = index;
              });
              // ref.invalidate(productDetailProvider);
            },
            child: Container(
              padding: const EdgeInsets.all(3.0),
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: count == index
                    ? Border.all(
                        color: const Color.fromARGB(255, 219, 100, 70),
                      )
                    : null,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(product.images[index]),
                  placeholder: const AssetImage('assets/1.gif'),
                ),

                // Image.network(
                //   product.images[index],
                //   fit: BoxFit.cover,
                //   width: size.width * 0.15,
                //   loadingBuilder: (context, child, loadingProgress) {
                //     return FadeIn(child: child);
                //   },
                // ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// class _ProductInformation extends ConsumerWidget {
//   final Product product;
//   const _ProductInformation({required this.product});

//   @override
//   Widget build(BuildContext context, WidgetRef ref ) {

//     final productForm = ref.watch( productFormProvider(product) );

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text('Generales'),
//           const SizedBox(height: 15 ),
//           CustomProductField(
//             isTopField: true,
//             label: 'Nombre',
//             initialValue: productForm.title.value,
//             onChanged: ref.read( productFormProvider(product).notifier).onTitleChanged,
//             errorMessage: productForm.title.errorMessage,
//           ),

//           CustomProductField(
//             label: 'Slug',
//             initialValue: productForm.slug.value,
//             onChanged: ref.read( productFormProvider(product).notifier).onSlugChanged,
//             errorMessage: productForm.slug.errorMessage,
//           ),

//           CustomProductField(
//             isBottomField: true,
//             label: 'Precio',
//             keyboardType: const TextInputType.numberWithOptions(decimal: true),
//             initialValue: productForm.price.value.toString(),
//             onChanged: (value)
//               => ref.read( productFormProvider(product).notifier)
//                 .onPriceChanged( double.tryParse(value) ?? -1 ),
//             errorMessage: productForm.price.errorMessage,
//           ),

//           const SizedBox(height: 15 ),
//           const Text('Extras'),

//           _SizeSelector(
//             selectedSizes: productForm.sizes,
//             onSizesChanged: ref.read( productFormProvider(product).notifier).onSizeChanged,
//           ),
//           const SizedBox(height: 5 ),
//           _GenderSelector(
//             selectedGender: productForm.gender,
//             onGenderChanged: ref.read( productFormProvider(product).notifier).onGenderChanged,
//           ),

//           const SizedBox(height: 15 ),
//           CustomProductField(
//             isTopField: true,
//             label: 'Existencias',
//             keyboardType: const TextInputType.numberWithOptions(decimal: true),
//             initialValue: productForm.inStock.value.toString(),
//             onChanged: ( value )
//               => ref.read( productFormProvider(product).notifier)
//                 .onStockChanged( int.tryParse(value) ?? -1 ),
//             errorMessage: productForm.inStock.errorMessage,
//           ),

//           CustomProductField(
//             maxLines: 6,
//             label: 'Descripción',
//             keyboardType: TextInputType.multiline,
//             initialValue: product.description,
//             onChanged: ref.read( productFormProvider(product).notifier).onDescriptionChanged,
//           ),

//           CustomProductField(
//             isBottomField: true,
//             maxLines: 2,
//             label: 'Tags (Separados por coma)',
//             keyboardType: TextInputType.multiline,
//             initialValue: product.tags.join(', '),
//             onChanged: ref.read( productFormProvider(product).notifier).onTagsChanged,
//           ),

//           const SizedBox(height: 100 ),
//         ],
//       ),
//     );
//   }
// }

class _SizeSelector extends StatelessWidget {
  final List<dynamic> selectedSizes;
  final List<dynamic> sizes = const ['XS', 'S', 'M', 'L', 'XL', 'XXL', 'XXXL'];

  final void Function(List<dynamic> selectedSizes) onSizesChanged;

  const _SizeSelector({
    required this.selectedSizes,
    required this.onSizesChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      emptySelectionAllowed: true,
      showSelectedIcon: false,
      segments: sizes
          .map((size) => ButtonSegment(
              value: size,
              label: Text(size, style: const TextStyle(fontSize: 10))))
          .toList(),
      selected: Set.from(selectedSizes),
      onSelectionChanged: (newSelection) {
        FocusScope.of(context).unfocus();
        onSizesChanged(List.from(newSelection));
      },
      multiSelectionEnabled: true,
    );
  }
}

class _ShimmerDetail extends StatelessWidget {
  const _ShimmerDetail({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const CustomShimmer(height: 300),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomShimmer(height: 60, width: 60),
                    CustomShimmer(height: 60, width: 60),
                    CustomShimmer(height: 60, width: 60),
                    CustomShimmer(height: 60, width: 60),
                    CustomShimmer(height: 60, width: 60),
                  ],
                ),
              ),
              Container(
                color: const Color.fromARGB(255, 235, 233, 233),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomShimmer(
                        height: 30,
                        width: size.width * 0.7,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CustomShimmer(
                        height: 200,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomShimmer(
                  height: 90,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomShimmer(
                  height: 90,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
