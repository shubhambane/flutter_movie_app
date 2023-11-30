import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:movieflix/data/models/movie.dart';
import 'package:movieflix/repository/movie_repository.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final MovieRepository _movieRepository = MovieRepository();
  NowPlayingBloc() : super(NowPlayingInitial()) {
    on<FetchNowPlayingEvent>(fetchNowPlayingEvent);
  }

  FutureOr<void> fetchNowPlayingEvent(
      FetchNowPlayingEvent event, Emitter<NowPlayingState> emit) async {
    try {
      emit(NowPlayingLoading());
      final List<Movie> movies = await _movieRepository.fetchNowPlayingMovies();
      emit(NowPlayingSuccess(movies));
      if (kDebugMode) {
        print('now playing movies fetched');
      }
    } catch (error) {
      emit(
        NowPlayingError(
          error.toString(),
        ),
      );
    }
  }
}
