import 'package:cineapp/presentation/screens/screen.dart';

import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/home/0', routes: [
  GoRoute(
      path: '/home/:page',
      builder: (context, state) {
        final pageIndex = state.pathParameters['page'] ?? 0;        
        return HomeScreen(page: int.parse(pageIndex.toString()));
      },
      routes: [
        GoRoute(
          path: 'movie/:id',
          name: MovieScreen.name,
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id';
            return MovieScreen(movieId: movieId);
          },
        ),
      ]),

  GoRoute(
    path: '/',
    redirect: (_, __) => '/home/0',
  )
  // GoRoute(
  //     path: '/favorites', builder: (context, state) => const FavoriteView()),
  // GoRoute(
  //     path: '/categories', builder: (context, state) => const CategoriesView()),
]);

// ShellRoute(
//     builder: (context, state, child) => HomeScreen(childView: child),
//     routes: [
//       GoRoute(
//           path: '/',
//           builder: (context, state) => const HomeView(),
//           routes: [
//             GoRoute(
//               path: 'movie/:id',
//               name: MovieScreen.name,
//               builder: (context, state) {
//                 return MovieScreen(
//                     movieId: state.pathParameters['id'] ?? 'no-id');
//               },
//             )
//           ]
//         ),
//       GoRoute(
//           path: '/favorites',
//           builder: (context, state) => const FavoriteView()),
//     ])

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
