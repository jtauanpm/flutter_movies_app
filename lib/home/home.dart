import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_movies_app/home/movie_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'movie.dart';

final moviesFutureProvider =
    FutureProvider.autoDispose<List<Movie>>((ref) async {
  ref.keepAlive();

  final movieService = ref.read(movieServiceProvider);
  final movies = await movieService.getMovies("Avatar");
  return movies;
});

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController textController = TextEditingController();

    void handleSubmit() {
      ref.refresh(moviesFutureProvider);
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Movies'),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final movies = ref.watch(moviesFutureProvider);
          return movies.when(
            error: (e, s) {
              return const Text("error");
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (movies) {
              return RefreshIndicator(
                onRefresh: () async {
                  ref.refresh(moviesFutureProvider);
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: textController,
                              decoration: const InputDecoration(
                                labelText: 'Busca por título',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ), // Espaçamento entre o TextField e o ElevatedButton
                          ElevatedButton(
                            onPressed: handleSubmit,
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.blue),
                            ),
                            child: const Text('Buscar'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: GridView.extent(
                        maxCrossAxisExtent: 200,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.7,
                        children: movies
                            .map((movie) => _MovieBox(movie: movie))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _MovieBox extends StatelessWidget {
  final Movie movie;

  const _MovieBox({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          movie.poster ?? "",
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _FrontBanner(text: movie.title ?? "Could not load this movie"),
        ),
      ],
    );
  }
}

class _FrontBanner extends StatelessWidget {
  const _FrontBanner({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          color: Colors.grey.shade200.withOpacity(0.5),
          height: 60,
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
