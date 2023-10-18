import 'package:flutter/material.dart';

class FavoriteView extends StatelessWidget {

  static const name = 'favorite_view';
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
      ),
      body: const Center(
        child: Text('Favorite'),
      ),
    );
  }
}