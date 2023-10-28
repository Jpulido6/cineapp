
import 'package:cineapp/domain/entities/actors.dart';



abstract class ActorsRepository {
  Future<List<Actors>> getActorsByMovie(String movieId);
}