

import 'package:cineapp/infrastructure/datasource/actors_moviedb_datasource.dart';
import 'package:cineapp/infrastructure/repository/actors_repository_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorRepositoryProvider = Provider((ref) => ActorsRepositoryImp( ActorsMoviedbDatasource()));