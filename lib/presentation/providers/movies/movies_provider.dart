import 'package:cineapp/domain/entities/movies.dart';
import 'package:cineapp/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final movieCallback = ref.watch(movieRepositoryProvider).getNowPlaying; 
  return MoviesNotifier(moviesCallback: movieCallback);
});


final popularMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final movieCallback = ref.watch(movieRepositoryProvider).getPopular; 
  return MoviesNotifier(moviesCallback: movieCallback);
});

final terrorMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final movieCallback = ref.watch(movieRepositoryProvider).getTerror; 
  return MoviesNotifier(moviesCallback: movieCallback);
});
final animationMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final movieCallback = ref.watch(movieRepositoryProvider).getAnimation; 
  return MoviesNotifier(moviesCallback: movieCallback);
});
final actionMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final movieCallback = ref.watch(movieRepositoryProvider).getAction; 
  return MoviesNotifier(moviesCallback: movieCallback);
});
final westernMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final movieCallback = ref.watch(movieRepositoryProvider).getWestern; 
  return MoviesNotifier(moviesCallback: movieCallback);
});
final comedyMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final movieCallback = ref.watch(movieRepositoryProvider).getComedy; 
  return MoviesNotifier(moviesCallback: movieCallback);
});


final upcomingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final movieCallback = ref.watch(movieRepositoryProvider).getUpcoming; 
  return MoviesNotifier(moviesCallback: movieCallback);
});



typedef MoviesCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  MoviesCallback moviesCallback;

  MoviesNotifier({required this.moviesCallback}) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;
    currentPage++;
    isLoading = true;
    final List<Movie> movies = await moviesCallback(page: currentPage);
    state = [...state, ...movies];
    await Future.delayed(const Duration(seconds: 2));
    isLoading = false;
  }
}
