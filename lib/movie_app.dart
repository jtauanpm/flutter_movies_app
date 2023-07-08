import 'package:flutter/material.dart';

import 'home/home.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData( // Defina o tema padrão como light (opcional)
        // Defina as cores para o tema Dark Mode
        // Você pode ajustar as cores conforme necessário
        colorScheme: const ColorScheme.dark(
          primary: Colors.blue
        ),
        // Outras propriedades do tema, como fontes e estilos, podem ser adicionadas aqui
      ),
      home: const HomePage(),
    );
  }
}
