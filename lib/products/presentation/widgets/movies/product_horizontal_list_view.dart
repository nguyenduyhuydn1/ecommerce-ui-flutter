import 'package:flutter/material.dart';

class ProductHorizontalListView extends StatelessWidget {
  final double widthProduct;
  final String title;
  final double height;
  const ProductHorizontalListView({
    super.key,
    this.widthProduct = 0.4,
    required this.title,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Title(title: title),
        SizedBox(
          height: height,
          child: ListView.builder(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return _Slide(
                widthProduct: widthProduct,
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
  const _Slide({required this.widthProduct});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

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
                  Image.asset(
                    'assets/images/1.jpg',
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Shirt 2\n".toUpperCase(),
                                style: textStyle.titleMedium
                                    ?.copyWith(fontSize: 17),
                              ),
                              TextSpan(
                                text: "Guci",
                                style: textStyle.titleMedium?.copyWith(
                                  fontSize: 17,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          "\$50",
                          style: TextStyle(color: Colors.green, fontSize: 20),
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
