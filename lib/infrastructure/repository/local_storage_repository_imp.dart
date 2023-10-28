import 'package:cineapp/domain/datasource/local_storage_datasource.dart';
import 'package:cineapp/domain/entities/movies.dart';
import 'package:cineapp/domain/repositories/local_storage_repository.dart';




class LocalStorageRepositoryImp extends LocalStorageRepository{


  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImp(this.datasource);
  @override
  Future<List<Movie>> getFavorites({int limit = 10, offset = 0}) {
      return datasource.getFavorites(limit: limit, offset: offset);
  }

  @override
  Future<bool> isMovieFavorite(int movieId) {
    return datasource.isMovieFavorite(movieId);
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    return datasource.toggleFavorite(movie);
  }


}