import 'package:cineapp/config/helpers/human_format.dart';
import 'package:cineapp/domain/entities/movies.dart';

import 'package:cineapp/presentation/providers/provider.dart';
import 'package:cineapp/presentation/widgets/videos/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie_screen';

  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorByMovieProvider.notifier).loadActor(widget.movieId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(slivers: [
        _CustomSliverAppBar(movie: movie),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => _MovieDetails(movie: movie),
                childCount: 1)),
      ]),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          movie.title,
          style: textStyle.titleLarge,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      const SizedBox(height: 5),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          movie.overview,
          style: textStyle.bodyMedium,
        ),
      ),
      const SizedBox(height: 5),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const Icon(Icons.star_outline, color: Colors.amber, size: 20),
            const SizedBox(width: 5),
            Text(
              movie.voteAverage.toString(),
              style: textStyle.bodySmall?.copyWith(color: Colors.amber),
            ),
            const SizedBox(width: 10),
            Text(
              HumanFormat.format(movie.popularity),
              style: textStyle.bodySmall,
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Wrap(children: [
          ...movie.genreIds.map((genre) => Container(
                margin: const EdgeInsets.only(right: 10),
                child: Chip(
                  label: Text(genre),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ))
        ]),
      ),
      const SizedBox(height: 10),


      

      _ActorByMovie(movieId: movie.id.toString()),
      const SizedBox(height: 10),

      VideoPlayer(movieId: movie.id),
      const SizedBox(height: 100),

    ]);
  }
}

class _ActorByMovie extends ConsumerWidget {
  final String movieId;
  const _ActorByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    final actorByMovie = ref.watch(actorByMovieProvider);

    if (actorByMovie[movieId] == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final actors = actorByMovie[movieId]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: actors.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final actor = actors[index];

          return Container(
            padding: const EdgeInsets.all(8.0),
            width: 135,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    actor.profilePath,
                    width: 135,
                    height: 180,
                    fit: BoxFit.cover,
                  )),
              const SizedBox(height: 5),
              Text(
                actor.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              Text(
                actor.character ?? '',
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              )
            ]),
          );
        },
      ),
    );
  }
}

final isFavoriteProvider = FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorage = ref.watch(LocalStorageRepositoryProvider);
  return localStorage.isMovieFavorite(movieId);
});

class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;
  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, ref) {
    final isFavorite = ref.watch(isFavoriteProvider(movie.id));
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
        actions: [
          IconButton(
              onPressed: () async {
                // ref.watch(LocalStorageRepositoryProvider).toggleFavorite(movie).then((_) =>
                
                // ref.invalidate(isFavoriteProvider(movie.id))
                // );

                await ref.read(favoriteMovieProvider.notifier).toggleFavorite(movie);

                ref.invalidate(isFavoriteProvider(movie.id));

              },
              icon: isFavorite.when(
                  data:(data) => data 
                  ? const Icon(Icons.favorite_rounded, color: Colors.red,)
                  : const Icon(Icons.favorite_border_rounded, color: Colors.white,),
                  error: (_, __) => throw UnimplementedError(),
                  loading: () => const CircularProgressIndicator(strokeWidth: 2,))
              // icon:
              // icon: ,
              )
        ],
        backgroundColor: Colors.black,
        expandedHeight: size.height * 0.7,
        foregroundColor: Colors.white,
        flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            titlePadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            // title: Text(
            //   movie.title,
            //   style: const TextStyle(fontSize: 18),
            //   maxLines: 2,
            //   overflow: TextOverflow.ellipsis,
            // ),
            background: Stack(
              children: [
                SizedBox.expand(
                  child: Image.network(
                    movie.posterPath,
                    fit: BoxFit.cover,
                  ),
                ),
                const _CustomGradient(
                  stops: [0.7, 1.0],
                  colors: [
                    Colors.transparent,
                    Colors.black87,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                const _CustomGradient(
                  stops: [0.0, 0.4],
                  colors: [
                    Colors.black87,
                    Colors.transparent,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.center,
                ),
                const _CustomGradient(
                  stops: [0.0, 0.2],
                  colors: [
                    Colors.black87,
                    Colors.transparent,
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                )
              ],
            )));
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry? end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient({
    required this.stops,
    required this.colors,
    required this.begin,
    this.end = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: begin, end: end!, stops: stops, colors: colors),
        ),
      ),
    );
  }
}
