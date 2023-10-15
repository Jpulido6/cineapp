
import 'package:cineapp/infrastructure/datasource/moviedb_datasource.dart';
import 'package:cineapp/infrastructure/repository/movie_repository_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final movieRepositoryProvider = Provider((ref){
  return MovieRepositoryImp( MoviedbDatasource() );
});


