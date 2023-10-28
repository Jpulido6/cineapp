import 'package:cineapp/domain/entities/actors.dart';
import 'package:cineapp/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final actorByMovieProvider = StateNotifierProvider<ActorByMovieNotifier, Map<String, List<Actors>>>((ref) {
  final actorCallback = ref.watch(actorRepositoryProvider); 
  return ActorByMovieNotifier(actorCallback: actorCallback.getActorsByMovie);
});

typedef getActorCallback = Future<List<Actors>> Function(String movieId);
class ActorByMovieNotifier extends StateNotifier<Map<String, List<Actors>>> {

  final getActorCallback actorCallback;
  ActorByMovieNotifier({
    required this.actorCallback
  }) : super({});

  Future<void> loadActor(String movieId) async {
    if(state[movieId] != null) return;
    final actors = await actorCallback( movieId );
    state = {...state, movieId: actors};
  }
}
