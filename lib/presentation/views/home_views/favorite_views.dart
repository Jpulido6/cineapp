import 'package:cineapp/presentation/providers/provider.dart';
import 'package:cineapp/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoriteView extends ConsumerStatefulWidget {
  static const name = 'favorite_view';
  const FavoriteView({super.key});
  @override
  FavoriteViewState createState() => FavoriteViewState();
}

class FavoriteViewState extends ConsumerState<FavoriteView> {
  bool isLoading = false;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();

    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;

    isLoading = true;

    final movie = await ref.read(favoriteMovieProvider.notifier).loadNextPage();

    isLoading = false;

    if (movie.isEmpty) isLastPage = true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movieFav = ref.watch(favoriteMovieProvider).values.toList();

    // 12eb94f62f91dae26657344c12c6334    7bf5016aec3e39d7e53f785e2651fc3076ab4ec4

    if ( movieFav.isEmpty){
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No tienes películas favoritas', style: TextStyle(fontSize: 20, ),),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go('/home/0');
              },
              child: const Text('Agregar una película'),
            ),

          ],
        ),
      );
    }
    return Scaffold(
      body: MovieMasonry(loadNextPage: loadNextPage, movies: movieFav),
    );
  }
}
