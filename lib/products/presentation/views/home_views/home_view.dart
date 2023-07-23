import 'package:flutter/material.dart';

import 'package:ecommerce_ui_flutter/shared/shared.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
            centerTitle: true,
          ),
          backgroundColor: Colors.green,
        ),
        SliverToBoxAdapter(
          child: Text("asdsad"),
        )
        //  SliverList(
        //   delegate: SliverChildBuilderDelegate(
        //     childCount: 1,
        //     (context, index) {
        //       return Column(
        //         children: [
        //           MovieSlideShow(movies: slideShowMovies),
        //           MoviesHorizontalListview(
        //             movies: nowPlayMovies,
        //             title: "new",
        //             subTitle: "Monday",
        //             loadNextPage: () => ref
        //                 .read(nowPlayingMoviesProvider.notifier)
        //                 .loadNextPage(),
        //           ),
        //           MoviesHorizontalListview(
        //             movies: popularMovies,
        //             title: "populary",
        //             subTitle: "Monday",
        //             loadNextPage: () =>
        //                 ref.read(popularMoviesProvider.notifier).loadNextPage(),
        //           ),
        //           MoviesHorizontalListview(
        //             movies: upComingMovies,
        //             title: "coming",
        //             subTitle: "Monday",
        //             loadNextPage: () => ref
        //                 .read(upComingMoviesProvider.notifier)
        //                 .loadNextPage(),
        //           ),
        //           MoviesHorizontalListview(
        //             movies: topRateMovies,
        //             title: "top rated",
        //             subTitle: "Monday",
        //             loadNextPage: () =>
        //                 ref.read(topRateMoviesProvider.notifier).loadNextPage(),
        //           ),
        //           const SizedBox(height: 10)
        //         ],
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}
