import 'package:cineapp/domain/entities/movies.dart';
import 'package:cineapp/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchMovieProvider = StateProvider<String>((ref) => '');

final searchMoviesProvider =
    StateNotifierProvider<SearchMoviesNotifier, List<Movie>>((ref) {
  final searchMovie = ref.read(movieRepositoryProvider);
  return SearchMoviesNotifier(ref: ref, searchMovie: searchMovie.searchMovie);
});

typedef SearchMovieCallback = Future<List<Movie>> Function(String query);

class SearchMoviesNotifier extends StateNotifier<List<Movie>> {
  final SearchMovieCallback searchMovie;
  final Ref ref;

  SearchMoviesNotifier({required this.searchMovie, required this.ref})
      : super([]);

  Future<List<Movie>> getMovie(String query) async {
    final List<Movie> movies = await searchMovie(query);
    ref.read(searchMovieProvider.notifier).update((state) => query);

    state = movies;
    return movies;
  }
}
