import 'package:card_swiper/card_swiper.dart';
import 'package:cineapp/domain/entities/movies.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoviesSlideshow extends StatelessWidget {
  final List<Movie> movies;

  const MoviesSlideshow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 220,
      width: double.infinity,
      child: Swiper(
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            activeColor: theme.primary,
            color: theme.secondaryContainer,
            
            )
        ),
        viewportFraction: 0.8,
        scale: 0.9,
        autoplay: true,
        itemCount: movies.length,
        itemBuilder: (context, index) => _SliderView(movie: movies[index]),
      ),
    );
  }
}

class _SliderView extends StatelessWidget {
  final Movie movie;
  const _SliderView({required this.movie});

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
        blurRadius: 10,
        color: Colors.black45,
        offset: Offset(0, 10)
      )]
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            movie.backdropPath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if(loadingProgress != null){
                return const DecoratedBox(decoration: BoxDecoration(color: Colors.black12));
              }
              return GestureDetector(
                onTap: () => context.push('/home/0/movie/${movie.id}'),
                child: child
              );
            },
            ),
        ),
        ),
    );
  }
}
