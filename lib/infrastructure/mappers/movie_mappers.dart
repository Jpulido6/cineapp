import 'package:cineapp/domain/entities/movies.dart';
import 'package:cineapp/infrastructure/models/moviedb/movie_details.dart';
import 'package:cineapp/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDb movieDB) => Movie(
        adult: movieDB.adult,
        backdropPath:( movieDB.backdropPath != '')
        ? 'https://image.tmdb.org/t/p/w500/${movieDB.backdropPath}'
        : 'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg' ,
        genreIds: movieDB.genreIds.map((e) => e.toString()).toList(),
        id: movieDB.id,
        originalLanguage: movieDB.originalLanguage,
        originalTitle: movieDB.originalTitle,
        overview: movieDB.overview,
        popularity: movieDB.popularity,
        posterPath: ( movieDB.posterPath != '')
        ? 'https://image.tmdb.org/t/p/w500/${movieDB.posterPath}'
        : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQP8n_VcmefHmHxO3n9bXSMODS_8pGjmKKGbA&usqp=CAU',
        releaseDate: movieDB.releaseDate !=null ? movieDB.releaseDate! : DateTime.now(),
        title: movieDB.title,
        video: movieDB.video,
        voteAverage: movieDB.voteAverage,
        voteCount: movieDB.voteCount,
      );

  static Movie MovieDetailsToEntity(MovieDetails movieDetails) => Movie(
    adult: movieDetails.adult,
        backdropPath:( movieDetails.backdropPath != '')
        ? 'https://image.tmdb.org/t/p/w500/${movieDetails.backdropPath}'
        : 'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg' ,
        genreIds: movieDetails.genres.map((e) => e.name).toList(),
        id: movieDetails.id,
        originalLanguage: movieDetails.originalLanguage,
        originalTitle: movieDetails.originalTitle,
        overview: movieDetails.overview,
        popularity: movieDetails.popularity,
        posterPath: ( movieDetails.posterPath != '')
        ? 'https://image.tmdb.org/t/p/w500/${movieDetails.posterPath}'
        : 'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg',
        releaseDate: movieDetails.releaseDate,
        title: movieDetails.title,
        video: movieDetails.video,
        voteAverage: movieDetails.voteAverage,
        voteCount: movieDetails.voteCount,
  );
}
