// lib/repository/movie_repository.dart

import 'package:movieflix/data/api/movie_api_provider.dart';
import 'package:movieflix/data/models/movie.dart';

class MovieRepository {
  final MovieApiProvider _movieApiProvider = MovieApiProvider();

  Future<List<Movie>> fetchNowPlayingMovies() async {
    return _movieApiProvider.fetchNowPlayingMovies();
  }

  Future<List<Movie>> fetchTopRatedMovies() async {
    return _movieApiProvider.fetchTopRatedMovies();
  }
}
