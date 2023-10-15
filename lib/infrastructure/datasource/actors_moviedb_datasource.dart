import 'package:cineapp/config/constants/environment.dart';
import 'package:cineapp/domain/datasource/actors_datasource.dart';
import 'package:cineapp/domain/entities/actors.dart';
import 'package:cineapp/infrastructure/mappers/actors_mappers.dart';
import 'package:cineapp/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorsMoviedbDatasource extends ActorsDatasource {
  final dio = Dio(
    BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
      'api_key': Environment.apiKey,
      'language': 'es-MX',
    }),
  );
  @override
  Future<List<Actors>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    final castResponse = CreditsResponse.fromJson(response.data);

    final List<Actors> actor = castResponse.cast
        .map((actor) => ActorMapper.castToEntity(actor))
        .toList();

    return actor;
  }

  // List<Actors> _jsonToActor(Map<String, dynamic> json) {
  //   final actors = CreditsResponse.fromJson(json);

  //   final List<Actors> actor =
  //       actors.cast.map((actor) => ActorMapper.castToEntity(actor)).toList();

  //   return actor;
  // }
}
