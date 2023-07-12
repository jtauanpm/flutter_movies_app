import 'package:flutter/material.dart';
import 'package:flutter_movies_app/Services/movie_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Widgets/movie_box.dart';
import '../Widgets/movie_error.dart';
import '../models/movie.dart';

final moviesFutureProvider =
    FutureProvider.autoDispose<List<Movie>>((ref) async {
  ref.keepAlive();

  final movieService = ref.read(movieServiceProvider);
  final movies = await movieService.getMovies();
  return movies;
});

class MoviesPage extends ConsumerWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController textController = TextEditingController();
    final TextEditingController yearController = TextEditingController();

    void handleSubmit() {
      ref.read(movieServiceProvider).setSearchTitle(textController.text);
      ref.read(movieServiceProvider).setSearchYear(yearController.text);
      var _ = ref.refresh(moviesFutureProvider);
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Movies',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: handleSubmit,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      labelText: 'Buscar por título',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 1, horizontal: 5),
                    ),
                    style: const TextStyle(fontSize: 14),
                    minLines: 1,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: yearController,
                    decoration: InputDecoration(
                      labelText: 'Buscar por ano',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 1, horizontal: 5),
                    ),
                    style: const TextStyle(fontSize: 14),
                    minLines: 1,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                var _ = ref.refresh(moviesFutureProvider);
              },
              child: _buildMoviesGrid(ref),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoviesGrid(WidgetRef ref) {
    final movies = ref.watch(moviesFutureProvider);

    return movies.when(
      error: (e, s) {
        return MovieError(error: e);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      data: (movies) {
        return GridView.extent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.7,
          children: movies.map((movie) => MovieBox(movie: movie)).toList(),
        );
      },
    );
  }
}
