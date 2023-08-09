import 'package:animate_do/animate_do.dart';
import 'package:ecommerce_ui_flutter/products/domain/entities/product.dart';
import 'package:ecommerce_ui_flutter/products/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  @override
  void initState() {
    super.initState();
    ref.read(favoritesProvider.notifier).getDataFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoritesProvider);

    if (favorites.isEmpty) {
      return const Center(
        child: Text("Like some products"),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final product = favorites[index];

          return _FavoriteItem(product: product);
        },
      ),
    );
  }
}

class _FavoriteItem extends StatelessWidget {
  const _FavoriteItem({
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var price =
        NumberFormat.simpleCurrency(decimalDigits: 0).format(product.price);
    final textStyle = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        context.push('/product/${product.id}');
      },
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
                    product.images[0],
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
                  //   image: NetworkImage(product.images[0]),
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
                    product.name.toUpperCase(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle.titleMedium?.copyWith(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    product.brand,
                    style: textStyle.titleMedium?.copyWith(
                      fontSize: 17,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    price,
                    style: const TextStyle(color: Colors.green, fontSize: 16),
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
