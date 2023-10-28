import 'package:cineapp/config/helpers/human_format.dart';
import 'package:cineapp/domain/entities/movies.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieHorizontalListview extends StatefulWidget {
  final List<Movie> movies;
  final String? tittle;
  final String? subTittle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview(
      {super.key,
      required this.movies,
      this.tittle,
      this.subTittle,
      this.loadNextPage});

  @override
  State<MovieHorizontalListview> createState() =>
      _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      if ((scrollController.position.pixels + 150) >=
          scrollController.position.maxScrollExtent) {
       
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (widget.tittle != null || widget.subTittle != null)
            _Tittle(
              title: widget.tittle,
              subTitle: widget.subTittle,
            ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (context, index) =>
                _SLides(movie: widget.movies[index]),
          ))
        ],
      ),
    );
  }
}

class _SLides extends StatelessWidget {
  final Movie movie;
  const _SLides({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 8),
        SizedBox(
          width: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              movie.posterPath,
              width: 150,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return const Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        widthFactor: 3,
                        heightFactor: 3,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ));
                }
                return GestureDetector(
                onTap: () => context.push('/home/0/movie/${movie.id}'),
                child: child
              );
              },
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: 150,
          child: Text(movie.title,
              style: textStyle.titleSmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
        ),
        Row(
          children: [
            const Icon(Icons.star_outline, color: Colors.amber, size: 15),
            const SizedBox(width: 5),
            Text(
              movie.voteAverage.toString(),
              style: textStyle.bodySmall?.copyWith(color: Colors.amber),
            ),
            const SizedBox(width: 10),
            Text(
              HumanFormat.format(movie.popularity),
              style: textStyle.bodySmall,
            )
          ],
        )
      ]),
    );
  }
}

class _Tittle extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const _Tittle({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {


    final tittleStyle = Theme.of(context).textTheme.titleLarge;



    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              style: tittleStyle,
            ),
          const Spacer(),
          if (subTitle != null)
          FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {},
              child: Text(subTitle!))
        ],
      ),
    );
  }
}
