import 'package:cineapp/domain/entities/movies.dart';
import 'package:cineapp/domain/repositories/local_storage_repository.dart';
import 'package:cineapp/presentation/providers/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteMovieProvider =
    StateNotifierProvider<StorageMovieNotifier, Map<int, Movie>>((ref) {
  final localStorageRepository = ref.watch(LocalStorageRepositoryProvider);

  return StorageMovieNotifier(localStorageRepository: localStorageRepository);
});

class StorageMovieNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final LocalStorageRepository localStorageRepository;

  StorageMovieNotifier({required this.localStorageRepository}) : super({});

  Future<List<Movie>> loadNextPage() async {
    final movie =
        await localStorageRepository.getFavorites(offset: page * 10, limit: 20);
    page++;

    final tempMovie = <int, Movie>{};
    for (final movies in movie) {
      tempMovie[movies.id] = movies;
    }

    state = {...state, ...tempMovie};

    return movie;
  }

  Future<void> toggleFavorite(Movie movie) async {
    await localStorageRepository.toggleFavorite(movie);

    final bool isFavorite = state[movie.id] != null;

    if (isFavorite) {
      state.remove(movie.id);
      state = {...state};
    } else {
      state = {...state, movie.id: movie};
    }
  }
}
