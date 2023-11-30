import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:movieflix/core/constants/api_constants.dart';
import 'package:movieflix/data/models/movie.dart';

class MovieApiProvider {
  Future<List<Movie>> fetchNowPlayingMovies() async {
    try {
      final response = await http.get(Uri.parse(MApiConstants.mNowPlayingApi));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> results = data['results'];

        return results.map((movieData) => Movie.fromJson(movieData)).toList();
      } else {
        if (kDebugMode) {
          print(
              'Failed to load now playing movies. Status code: ${response.statusCode}');
        }
        return [];
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching now playing movies: $error');
      }
      return [];
    }
  }

  Future<List<Movie>> fetchTopRatedMovies() async {
    try {
      final response = await http.get(Uri.parse(MApiConstants.mTopRatedApi));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> results = data['results'];

        return results.map((movieData) => Movie.fromJson(movieData)).toList();
      } else {
        if (kDebugMode) {
          print(
              'Failed to load top-rated movies. Status code: ${response.statusCode}');
        }
        return [];
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching top-rated movies: $error');
      }
      return [];
    }
  }
}
