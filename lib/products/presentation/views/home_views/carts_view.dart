import 'package:animate_do/animate_do.dart';
import 'package:ecommerce_ui_flutter/auth/presentation/providers/auth_provider.dart';
import 'package:ecommerce_ui_flutter/products/domain/domain.dart';
import 'package:ecommerce_ui_flutter/products/presentation/providers/storage/carts_product_provider.dart';
import 'package:ecommerce_ui_flutter/shared/infrastructure/services/stripe_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CartsView extends ConsumerStatefulWidget {
  const CartsView({super.key});

  @override
  CartsViewState createState() => CartsViewState();
}

class CartsViewState extends ConsumerState {
  @override
  void initState() {
    super.initState();
    ref.read(cartsProvider.notifier).getDataCarts();
  }

  @override
  Widget build(BuildContext context) {
    final carts = ref.watch(cartsProvider);
    final auth = ref.watch(authProvider).user;
    final addAndMinus = ref.read(cartsProvider.notifier).addAndMinusCarts;
    final size = MediaQuery.of(context).size;

    var sum = 0;
    carts.toList().forEach((e) => sum += e.price * e.qty!);
    var total = NumberFormat.simpleCurrency(decimalDigits: 0).format(sum);

    if (carts.isEmpty) {
      return const Center(
        child: Text("null"),
      );
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: size.height * 0.8,
            child: CustomScrollView(
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
                    childCount: carts.length,
                    (context, index) {
                      final item = carts[index];

                      return Dismissible(
                        key: Key(item.id),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          setState(() {
                            ref
                                .read(cartsProvider.notifier)
                                .removeDataCarts(item.id);
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
                            item: item,
                            addAndMinust: addAndMinus,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: size.height * 0.1,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, -15),
                  blurRadius: 20,
                  color:
                      const Color.fromARGB(255, 179, 176, 176).withOpacity(0.5),
                )
              ],
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        total,
                        style:
                            const TextStyle(color: Colors.green, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: size.width * 0.5,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () async {
                      if (auth!.hasShippingAddress) {
                        final temp = StripeService();
                        final a = await temp.makePayment(sum, auth.fullname);
                        if (a == true) {
                          ref.read(cartsProvider.notifier).emptyCarts();
                        }
                      } else {
                        context.push('/profile');
                      }
                    },
                    child: const Text(
                      "Check Out",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Carts extends StatelessWidget {
  final Product item;
  final Future<void> Function(String, int) addAndMinust;
  const _Carts({required this.item, required this.addAndMinust});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    var price =
        NumberFormat.simpleCurrency(decimalDigits: 0).format(item.price);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width * 0.3,
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    item.images[0],
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress != null) {
                        return Image.asset('assets/1.gif');
                      }
                      return FadeIn(child: child);
                    },
                  ),

                  // FadeInImage(
                  //   fit: BoxFit.cover,
                  //   image: NetworkImage(item.images[0]),
                  //   placeholder: const AssetImage('assets/1.gif'),
                  // ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            SizedBox(
              width: size.width * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name.toUpperCase(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle.titleMedium?.copyWith(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    item.brand,
                    style: textStyle.titleMedium?.copyWith(
                      fontSize: 17,
                      color: Colors.green,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style:
                            const TextStyle(color: Colors.green, fontSize: 16),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  addAndMinust(item.id, 1);
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                            Text(
                              "${item.qty}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                            IconButton(
                                onPressed: () {
                                  addAndMinust(item.id, -1);
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
