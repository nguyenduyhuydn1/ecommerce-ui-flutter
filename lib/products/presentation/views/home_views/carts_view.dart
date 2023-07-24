import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartsView extends StatefulWidget {
  const CartsView({super.key});

  @override
  State<CartsView> createState() => _CartsViewState();
}

class _CartsViewState extends State<CartsView> {
  int count = 140;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text("Your Cart"),
            centerTitle: true,
          ),
          backgroundColor: Colors.green,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: count,
            (context, index) {
              return Dismissible(
                //void error handler ondismissed, make sure u will do this func when application is success
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    count -= 1;
                  });
                },
                background: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE6E6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const Spacer(),
                      SvgPicture.asset("assets/icons/Trash.svg"),
                    ],
                  ),
                ),
                child: FadeInUp(
                  child: _Carts(
                    index: index,
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

class _Carts extends StatelessWidget {
  final int index;
  const _Carts({required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset('assets/images/1.jpg'),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "shirt",
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                text: "\$50",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.green),
                children: [
                  const WidgetSpan(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0),
                    ),
                  ),
                  TextSpan(
                      text: "x $index",
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
