import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Services/movie_service.dart';
import '../models/movie.dart';

class MovieDetails extends ConsumerWidget {
  final String id;

  const MovieDetails({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieService = ref.read(movieServiceProvider);

    return FutureBuilder<Movie>(
      future: movieService.getMovie(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: _appBarDetail(context),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: _appBarDetail(context),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          final movie = snapshot.data;

          return Scaffold(
            appBar: _appBarDetail(context),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16.0),
                    child: Image.network(
                      movie?.poster ?? "",
                      fit: BoxFit.cover,
                      width: 200,
                      height: 300,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextWidget('Title', movie?.title),
                        _buildTextWidget('Year', movie?.year),
                        _buildTextWidget('Released', movie?.released),
                        _buildTextWidget('Runtime', movie?.runtime),
                        _buildTextWidget('Genre', movie?.genre),
                        _buildTextWidget('Director', movie?.director),
                        _buildTextWidget('Writer', movie?.writer),
                        _buildTextWidget('Actors', movie?.actors),
                        _buildTextWidget('Plot', movie?.plot),
                        _buildTextWidget('Language', movie?.language),
                        _buildTextWidget('Country', movie?.country),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildTextWidget(String label, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label ',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value ?? '',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  AppBar _appBarDetail(BuildContext context) {
    return AppBar(
      toolbarHeight: 40,
      backgroundColor: Colors.blue,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Movie Details',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
