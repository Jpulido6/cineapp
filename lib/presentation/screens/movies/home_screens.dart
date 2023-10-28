import 'package:cineapp/presentation/views/views.dart';
import 'package:cineapp/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  final int page;

  const HomeScreen({super.key, required this.page});

  final viewRoutes = const <Widget>[
    HomeView(),
    CategoriesView(),
    FavoriteView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: page,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: page,
      ),
    );
  }
}
