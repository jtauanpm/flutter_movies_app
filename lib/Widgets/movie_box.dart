import 'package:flutter/material.dart';
import 'package:flutter_movies_app/Screens/movie_details.dart';

import '../models/movie.dart';
import 'front_banner.dart';

class MovieBox extends StatelessWidget {
  final Movie movie;

  const MovieBox({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MovieDetails(id: movie.imdbID ?? ""),
          ),
        );
      },
      child: Stack(
        children: [
          Image.network(
            movie.poster ?? "",
            fit: BoxFit.cover,
            width: double.infinity,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child:
                FrontBanner(text: movie.title ?? "Could not load this movie"),
          ),
        ],
      ),
    );
  }
}
