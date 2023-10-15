import 'package:cineapp/domain/entities/movies.dart';
import 'package:cineapp/presentation/providers/movies/movies_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moviesSlideshowProvider = Provider<List<Movie>>((ref) {
  final movies = ref.watch(nowPlayingMoviesProvider);

  if (movies.isEmpty) return [];

  return movies.sublist(0, 6);
});
