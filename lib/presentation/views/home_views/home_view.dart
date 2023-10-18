import 'package:cineapp/presentation/providers/provider.dart';
import 'package:cineapp/presentation/widgets/widgets.dart';

import'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(terrorMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final initialLoading = ref.watch(initialLoadingProvider);

    if (initialLoading) {
      return const CustomFullScreenLoader();
    }
    final movies = ref.watch(nowPlayingMoviesProvider);
    final slidesMovies = ref.watch(moviesSlideshowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final terrorMovies = ref.watch(terrorMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    if (slidesMovies.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    

    return CustomScrollView(

      slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace:Flexible(child: CustomAppBar()), 
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return Column(children: [
            MoviesSlideshow(movies: slidesMovies),
            MovieHorizontalListview(
                movies: movies,
                tittle: 'En Cine',
                
                loadNextPage: () =>
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage()),
            MovieHorizontalListview(
                movies: popularMovies,
                tittle: 'Populares',
                // subTittle: 'Martes 3',
                loadNextPage: () =>
                    ref.read(popularMoviesProvider.notifier).loadNextPage()),
            MovieHorizontalListview(
                movies: terrorMovies,
                tittle: 'Terror',
                subTittle: 'Martes 3',
                loadNextPage: () =>
                    ref.read(terrorMoviesProvider.notifier).loadNextPage()),
            MovieHorizontalListview(
                movies: upcomingMovies,
                tittle: 'Próximamente',
                subTittle: 'Martes 3',
                loadNextPage: () =>
                    ref.read(upcomingMoviesProvider.notifier).loadNextPage()),

          ]);
        }, childCount: 1),
      )
    ]);
  }
}