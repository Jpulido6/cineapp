

import 'package:cineapp/domain/entities/movies.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getNowPlaying( { int page = 1});
  Future<List<Movie>> getPopular( { int page = 1});
  Future<List<Movie>> getTerror( { int page = 1});
  Future<List<Movie>> getUpcoming( { int page = 1});
  Future <Movie> getMovieById(String id);

  Future<List<Movie>> searchMovie(String query);
  
}