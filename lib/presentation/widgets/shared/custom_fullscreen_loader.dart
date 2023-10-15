import 'package:flutter/material.dart';

class CustomFullScreenLoader extends StatelessWidget {
  const CustomFullScreenLoader({super.key});

  Stream<String> getMessageLoader() {
    final message = <String>[
      'Cargando Películas...',
      'Cargando Categorías...',
      'Cargando Favoritos...',
      'Cargando Populares...',
      'Cargando Terror...',
      'Cargando Upcoming...'
    ];

    return Stream.periodic(const Duration(seconds: 1), (step) {
      return message[step];
    }).take(message.length);
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      
      const SizedBox(height: 10),
      const CircularProgressIndicator(
        strokeWidth: 2,
      ),
      const SizedBox(height: 10),
      StreamBuilder(
        stream: getMessageLoader(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text('Cargando...');
          return Text(snapshot.data!);
        }
      )
    ]));
  }
}
