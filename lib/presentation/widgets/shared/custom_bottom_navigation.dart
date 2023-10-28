import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {

  final int  currentIndex;
  // int indexCurrent(BuildContext context) {
  //   final String location = GoRouterState.of(context).matchedLocation;
  //   switch (location) {
  //     case '/':
  //       return 0;
  //     case '/categories':
  //       return 1;
  //     case '/favorites':
  //       return 2;
  //     default:
  //       return 0;
  //   }
  // }
  const CustomBottomNavigation({super.key, required this.currentIndex});
  void onTaped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home/0');
        break;
      case 1:
        context.go('/home/1');
        break;
      case 2:
        context.go('/home/2');
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => onTaped(context, index),
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            label: 'Inicio',
            icon: Icon(Icons.home_max_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Categoría',
            icon: Icon(Icons.label_outline),
          ),
          BottomNavigationBarItem(
            label: 'Favoritos',
            icon: Icon(Icons.favorite_border_rounded),
          ),
        ]);
  }
}
