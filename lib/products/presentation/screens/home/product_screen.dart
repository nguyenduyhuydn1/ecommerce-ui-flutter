import 'package:animate_do/animate_do.dart';
import 'package:ecommerce_ui_flutter/products/domain/domain.dart';
import 'package:ecommerce_ui_flutter/products/presentation/providers/product_detail_provider.dart';
import 'package:ecommerce_ui_flutter/products/presentation/views/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  @override
  Widget build(BuildContext context) {
    final Product? product = ref.watch(productDetailProvider)[widget.productId];
    final size = MediaQuery.of(context).size;

    if (product == null) return _ShimmerDetail(size: size);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                // Icons.favorite_outline,
                Icons.favorite_outlined,
                color: Colors.red,
              ),
            ),
          )
        ],
      ),
      body: Padding(
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
            listImages(product, size)
          ],
        ),
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
                child: Image.network(
                  product.images[index],
                  fit: BoxFit.cover,
                  width: size.width * 0.15,
                  loadingBuilder: (context, child, loadingProgress) {
                    return FadeIn(child: child);
                  },
                ),
              ),
            ),
          );
        },
      ),
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
