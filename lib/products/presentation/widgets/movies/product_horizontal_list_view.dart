import 'package:flutter/material.dart';

class ProductHorizontalListView extends StatelessWidget {
  const ProductHorizontalListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _Title(title: "Recomened"),
        SizedBox(
          height: 360,
          child: ListView.builder(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return const _Slide();
            },
          ),
        ),
      ],
    );
  }
}

class _Slide extends StatelessWidget {
  const _Slide();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/1.jpg',
                fit: BoxFit.cover,
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

    return Row(
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
    );
  }
}
