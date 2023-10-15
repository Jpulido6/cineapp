import 'package:cineapp/domain/datasource/movies_datasource.dart';
import 'package:cineapp/domain/entities/movies.dart';
import 'package:cineapp/domain/repositories/movies_repository.dart';

class MovieRepositoryImp implements MoviesRepository {
  final MoviesDatasource datasource;

  MovieRepositoryImp(this.datasource);
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }
  Future<List<Movie>> getTerror({int page = 1}) {
    return datasource.getTerror(page: page);
  }
  
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return datasource.getUpcoming(page: page);
  }

  Future <Movie> getMovieById(String id) {
    return datasource.getMovieById(id);
  }
  
  @override
  Future<List<Movie>> searchMovie(String query) {
    return datasource.searchMovie(query);
  }

}
