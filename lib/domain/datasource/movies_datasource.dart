import 'package:cineapp/domain/entities/movies.dart';
import 'package:cineapp/domain/entities/video.dart';

abstract class MoviesDatasource {
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getTerror({int page = 1});
  Future<List<Movie>> getAction({int page = 1});
  Future<List<Movie>> getComedy({int page = 1});
  Future<List<Movie>> getWestern({int page = 1});
  Future<List<Movie>> getAnimation({int page = 1});
  Future<List<Movie>> getUpcoming({int page = 1});
  Future<Movie> getMovieById(String id);
  Future<List<Movie>> searchMovie(String query);
  Future<List<Video>> getYoutubeVideosById(int movieId);
}
