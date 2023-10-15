import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      items: [
      BottomNavigationBarItem(
        label: 'Inicio',
        icon: IconButton(
        onPressed: () {},
        icon: Icon(Icons.home_max_outlined),
      
      )),
      BottomNavigationBarItem(
        label: 'Categoría',
        icon: IconButton(
        onPressed: () {},
        icon: Icon(Icons.label_outline),
      
      )),
      BottomNavigationBarItem(
        label: 'Favoritos',
        icon: IconButton(
        onPressed: () {},
        icon: Icon(Icons.favorite_border_rounded),
      
      )),
      
    ]);
  }
}