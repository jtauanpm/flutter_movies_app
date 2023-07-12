import 'package:flutter/material.dart';

class MovieError extends StatelessWidget {
  const MovieError({super.key, required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(227, 244, 67, 54),
        borderRadius: BorderRadius.circular(8),
      ),
      width: 350,
      height: 200,
      padding: const EdgeInsets.all(16),
      child: const Column(
        children: [
          Icon(
            Icons.error_outline_sharp,
            color: Colors.white,
            size: 48,
          ),
          SizedBox(height: 16),
          Text(
            "Nenhum registro encontrado para este filtro. Tente novamente com outro título e ano.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          // SizedBox(height: 8)
          // Text(
          //   "Detalhes do erro: $error",
          //   style: const TextStyle(
          //     color: Colors.white,
          //     fontSize: 14,
          //   ),
          // ),
        ],
      ),
    );
  }
}
