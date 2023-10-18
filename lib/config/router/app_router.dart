import 'package:cineapp/presentation/screens/screen.dart';

import 'package:cineapp/presentation/views/views.dart';

import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/', 
routes: [
  ShellRoute(
      builder: (context, state, child) => HomeScreen(childView: child),
      routes: [
        GoRoute(
            path: '/',
            builder: (context, state) => const HomeView(),
            routes: [
              GoRoute(
                path: 'movie/:id',
                name: MovieScreen.name,
                builder: (context, state) {
                  return MovieScreen(
                      movieId: state.pathParameters['id'] ?? 'no-id');
                },
              )
            ]
          ),
        GoRoute(
            path: '/favorites',
            builder: (context, state) => const FavoriteView()),
      ])

  // GoRoute(
  //   path: '/',
  //   name: HomeScreen.name,
  //   builder: (context, state) => const HomeScreen(childView: HomeView(),),
  //   routes: [
  //     GoRoute(
  //       path: 'movie/:id',
  //       name: MovieScreen.name,
  //       builder: (context, state){
  //         return MovieScreen(movieId: state.pathParameters['id'] ?? 'no-id');
  //       },
  //     )
  //   ]
  // ),
]);
