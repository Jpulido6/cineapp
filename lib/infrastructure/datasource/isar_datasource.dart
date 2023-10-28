import 'dart:io';

import 'package:cineapp/domain/datasource/local_storage_datasource.dart';
import 'package:cineapp/domain/entities/movies.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource extends LocalStorageDatasource {
  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [MovieSchema],
        directory: dir.path, 
        inspector: true
      );
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<List<Movie>> getFavorites({int limit = 10, offset = 0}) async {
    final isar = await db;

    return isar.movies.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db;
    final Movie? movieFav =
        await isar.movies.filter().idEqualTo(movieId).findFirst();
    return movieFav != null;
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;

    final movieFav =
        await isar.movies.filter().idEqualTo(movie.id).findFirst();

    if (movieFav != null) {
      isar.writeTxnSync(() => isar.movies.deleteSync(movieFav.isarId!));
      return;
    }

    isar.writeTxnSync(() => isar.movies.putSync(movie));
   
  }
}
