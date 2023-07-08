import 'package:flutter/material.dart';

import 'home/home.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: Colors.blue
        ),
      ),
      home: const HomePage(),
    );
  }
}
