import 'package:flutter/material.dart';
import 'package:flutter_movies_app/Screens/splash.dart';

import 'Screens/movie_list.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(primary: Colors.blue),
      ),
      home: const SplashScreen(),

      routes: {
        '/movies': (context) => const MoviesPage(),
        //'/movie-details': (context) => const
      },
    );
  }
}
