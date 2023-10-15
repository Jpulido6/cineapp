import 'package:cineapp/domain/entities/movies.dart';
import 'package:cineapp/presentation/delegates/search_movie_delegate.dart';
import 'package:cineapp/presentation/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              const Image(
                alignment: Alignment.centerLeft,
                image: AssetImage('assets/image/CINEAPP.png'),
                height: 40,
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  
                  final searchProvider = ref.read(searchMovieProvider);

                  showSearch<Movie?>(
                    query:searchProvider ,
                          context: context,
                          delegate: SearchMovieDelegate(
                              searchMovie:ref.read(searchMoviesProvider.notifier).getMovie))
                      .then((movie) => {
                            if (movie != null)
                              context.push('/movie/${movie.id}'),
                          });
                },
                icon: const Icon(Icons.search),
              )
            ])));
  }
}
