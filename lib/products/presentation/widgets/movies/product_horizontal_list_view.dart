import 'package:animate_do/animate_do.dart';
import 'package:ecommerce_ui_flutter/products/domain/entities/product.dart';
import 'package:flutter/material.dart';

class ProductHorizontalListView extends StatelessWidget {
  final double widthProduct;
  final String title;
  final double height;
  final List<Product> products;
  const ProductHorizontalListView({
    super.key,
    this.widthProduct = 0.4,
    required this.title,
    required this.height,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Title(title: title),
        SizedBox(
          height: height,
          child: ListView.builder(
            itemCount: products.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return FadeInRight(
                child: _Slide(
                  widthProduct: widthProduct,
                  product: products[index],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Slide extends StatelessWidget {
  final double widthProduct;
  final Product product;
  const _Slide({
    required this.widthProduct,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    final height = widthProduct == 0.4 ? 0.2 : 0.3;
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.green[50]!,
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            width: size.width * widthProduct,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Column(
                children: [
                  Image.network(
                    product.images[0],
                    fit: BoxFit.cover,
                    height: size.height * height,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${product.name} \n".toUpperCase(),
                                style: textStyle.titleMedium
                                    ?.copyWith(fontSize: 17),
                              ),
                              TextSpan(
                                text: product.brand,
                                style: textStyle.titleMedium?.copyWith(
                                  fontSize: 17,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "\$ ${product.price}",
                          style: const TextStyle(
                              color: Colors.green, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String title;

  const _Title({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.labelLarge;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 10, 5),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          SizedBox(
            // height: 35,
            child: FilledButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.green),
                visualDensity: VisualDensity.standard,
              ),
              onPressed: () {},
              child: Text(
                "More",
                style: titleStyle?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
