import 'package:cineapp/domain/datasource/actors_datasource.dart';
import 'package:cineapp/domain/entities/actors.dart';
import 'package:cineapp/domain/repositories/actors_repository.dart';

class ActorsRepositoryImp implements ActorsRepository {
  final ActorsDatasource datasource;

  ActorsRepositoryImp(this.datasource);
  @override
  Future<List<Actors>> getActorsByMovie(String movieId) {
    return this.datasource.getActorsByMovie(movieId);
  }
}
