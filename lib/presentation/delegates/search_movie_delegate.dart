import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cineapp/config/helpers/human_format.dart';
import 'package:cineapp/domain/entities/movies.dart';
import 'package:flutter/material.dart';

typedef SearchMovieCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMovieCallback searchMovie;
  List<Movie> initialMovies;

  StreamController<List<Movie>> debounce = StreamController.broadcast();
  StreamController<bool> isLoading = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate({
    required this.searchMovie,
    this.initialMovies = const [],
  });

  Widget buildSuggestionsAndResults() {
    return StreamBuilder(
        initialData: initialMovies,
        stream: debounce.stream,
        builder: (context, snapshot) {
          final movies = snapshot.data ?? [];

          return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return _MovieSearchItem(
                    movie: movie,
                    onMovieSelected: (context, movie) {
                      clearStream();
                      close(context, movie);
                    });
              });
        });
  }

  void clearStream() {
    debounce.close();
  }

  void _onQueryChanged(String query) {
    isLoading.add(true);
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final movie = await searchMovie(query);
      initialMovies = movie;

      debounce.add(movie);
      isLoading.add(false);
    });
  }

  @override
  String get searchFieldLabel => 'Buscar películas';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoading.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
                animate: true,
                spins: 10,
                child: const Icon(Icons.search_rounded));
          }
          return IconButton(
            onPressed: () => query = '',
            icon: const Icon(Icons.clear_rounded),
          );
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStream();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestionsAndResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    return buildSuggestionsAndResults();
  }
}

class _MovieSearchItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const _MovieSearchItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => onMovieSelected(context, movie),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            SizedBox(
                width: size.width * 0.2,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      movie.posterPath,
                    ))),
            const SizedBox(width: 10),
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: textStyle.titleLarge,
                    ),
                    const SizedBox(height: 5),
                    (movie.overview.length > 100)
                        ? Text('${movie.overview.substring(0, 100)}...')
                        : Text(movie.overview),
                    const SizedBox(height: 5),
                    Row(children: [
                      const Icon(Icons.star_outline,
                          color: Colors.amber, size: 20),
                      const SizedBox(width: 5),
                      Text(
                        HumanFormat.format(movie.voteAverage, 1),
                        style:
                            textStyle.bodySmall?.copyWith(color: Colors.amber),
                      ),
                      const SizedBox(width: 10),
                    ])
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
