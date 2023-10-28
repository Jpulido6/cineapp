import 'package:cineapp/domain/entities/movies.dart';
import 'package:cineapp/presentation/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MovieMasonry extends StatefulWidget {
  final List<Movie> movies;
  final VoidCallback? loadNextPage;

  const MovieMasonry({super.key, required this.movies, this.loadNextPage});

  @override
  State<MovieMasonry> createState() => MovieMasonryState();
}

class MovieMasonryState extends State<MovieMasonry> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

      scrollController.addListener(() { 
      if ( widget.loadNextPage == null ) return;

      if ( (scrollController.position.pixels + 100) >= scrollController.position.maxScrollExtent ) {
        widget.loadNextPage!();
      }

    });
  }

  @override
  void dispose() {
    super.dispose();

    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        controller: scrollController,
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          final movie = widget.movies[index];

          if (index == 1) {
            return Column(
              children: [
                const SizedBox(
                  height: 35,
                ),
                MoviesPosterLink(
                  movie: movie,
                )
              ],
            );
          }

          return MoviesPosterLink(
            movie: movie,
          );
        },
      ),
    );
  }
}
