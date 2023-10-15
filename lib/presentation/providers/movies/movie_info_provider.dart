import 'package:cineapp/domain/entities/movies.dart';
import 'package:cineapp/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final movieInfoProvider = StateNotifierProvider<MovieMapProvider, Map<String, Movie>>((ref) {
  return MovieMapProvider(getMovie: ref.watch(movieRepositoryProvider).getMovieById);
});



typedef getMovieCallback = Future<Movie> Function( String movieId);
class MovieMapProvider extends StateNotifier<Map<String, Movie>> {

  final getMovieCallback getMovie;
  MovieMapProvider({required this.getMovie}) : super({});


  Future<void> loadMovie(String movieId) async {
    if(state[movieId] != null) return;

    print('Loading movie $movieId');	


    final movie = await getMovie( movieId );
    state = {...state, movieId: movie};
  
  }

}