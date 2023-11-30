import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movieflix/data/models/movie.dart';

class MovieInfoScreen extends StatefulWidget {
  const MovieInfoScreen({super.key});

  @override
  State<MovieInfoScreen> createState() => _MovieInfoScreenState();
}

class _MovieInfoScreenState extends State<MovieInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)?.settings.arguments as Movie;
    final formattedDate =
        DateFormat('MMMM d, y').format(DateTime.parse(movie.releaseDate));

    return Scaffold(
      appBar: AppBar(
        title: const Text('MovieFlix'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 12),
              height: 500,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              movie.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: RichText(
                text: TextSpan(
                  text: 'Release Date: ',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: formattedDate,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: RichText(
                text: TextSpan(
                  text: 'Popularity: ',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: movie.popularity.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              movie.overview,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
