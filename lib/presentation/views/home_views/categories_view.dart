import 'package:cineapp/presentation/providers/movies/movies_provider.dart';
import 'package:cineapp/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesView extends ConsumerStatefulWidget {
  static const name = 'categories_view';
  const CategoriesView({super.key});

  @override
  CategoriesViewState createState() => CategoriesViewState();
}

class CategoriesViewState extends ConsumerState<CategoriesView> {
  @override
  void initState() {
    super.initState();
    ref.read(terrorMoviesProvider.notifier).loadNextPage();
    ref.read(animationMoviesProvider.notifier).loadNextPage();
    ref.read(actionMoviesProvider.notifier).loadNextPage();
    ref.read(comedyMoviesProvider.notifier).loadNextPage();
    ref.read(westernMoviesProvider.notifier).loadNextPage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final terror = ref.watch(terrorMoviesProvider);
    final animation = ref.watch(animationMoviesProvider);
    final action = ref.watch(actionMoviesProvider);
    final comedy = ref.watch(comedyMoviesProvider);
    final western = ref.watch(westernMoviesProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: Flexible(child: CustomAppBar()),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return Column(children: [
            MovieHorizontalListview(
              movies: action,
              loadNextPage: () =>
                  ref.read(actionMoviesProvider.notifier).loadNextPage(),
              tittle: 'Acción',
            ),
            MovieHorizontalListview(
              movies: terror,
              loadNextPage: () =>
                  ref.read(terrorMoviesProvider.notifier).loadNextPage(),
              tittle: 'Terror',
            ),
            MovieHorizontalListview(
              movies: western,
              loadNextPage: () =>
                  ref.read(westernMoviesProvider.notifier).loadNextPage(),
              tittle: 'Western',
            ),
            MovieHorizontalListview(
              movies: animation,
              loadNextPage: () =>
                  ref.read(animationMoviesProvider.notifier).loadNextPage(),
              tittle: 'Animación',
            ),
            MovieHorizontalListview(
              movies: comedy,
              loadNextPage: () =>
                  ref.read(comedyMoviesProvider.notifier).loadNextPage(),
              tittle: 'Comedia',
            ),
          ]);
        }, childCount: 1))
      ],
    );
  }
}
