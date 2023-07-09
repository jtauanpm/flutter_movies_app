import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_movies_app/Services/environment_config.dart';
import 'package:flutter_movies_app/models/movie.dart';

final movieServiceProvider = Provider<MovieService>((ref) {
  return MovieService(ref.read(environmentConfigProvider), Dio());
});

class MovieService {
  MovieService(this._environmentConfig, this._dio);

  final EnvironmentConfig _environmentConfig;
  final Dio _dio;
  var searchString = "Avatar";
  var searchYear = "";

  void setSearchString(String input) {
    searchString = input;
  }

  void setSearchYear(String input) {
    searchYear = input;
  }

  Future<List<Movie>> getMovies() async {
    final apiKey = _environmentConfig.movieApiKey;

    final uri =
        "https://omdbapi.com/?apikey=$apiKey&s=$searchString&y=$searchYear&Type=movie";

    print(uri);

    final response = await _dio.get(uri);

    final results = List<Map<String, dynamic>>.from(response.data['Search']);

    List<Movie> movies = results
        .map((movieData) => Movie.fromJson(movieData))
        .toList(growable: false);

    return movies;
  }
}
