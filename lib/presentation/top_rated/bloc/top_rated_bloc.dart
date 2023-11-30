import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:movieflix/data/models/movie.dart';
import 'package:movieflix/repository/movie_repository.dart';
part 'top_rated_event.dart';
part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final MovieRepository _movieRepository = MovieRepository();

  TopRatedBloc() : super(TopRatedInitial()) {
    on<FetchTopRatedEvent>(fetchTopRatedEvent);
  }

  FutureOr<void> fetchTopRatedEvent(
      FetchTopRatedEvent event, Emitter<TopRatedState> emit) async {
    try {
      emit(TopRatedLoading());
      final List<Movie> movies = await _movieRepository.fetchTopRatedMovies();
      emit(TopRatedSuccess(movies));
      if (kDebugMode) {
        print('top Rated movies fetched');
      }
    } catch (error) {
      emit(
        TopRatedError(
          error.toString(),
        ),
      );
    }
  }
}
