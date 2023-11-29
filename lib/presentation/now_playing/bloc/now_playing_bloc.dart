import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
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
      // Fetch data from the API using the repository
      final List<Movie> movies = await _movieRepository.fetchNowPlayingMovies();
      emit(NowPlayingSuccess(movies));
      print('now playing movies fetched');

      // print(movies[0].title);
    } catch (error) {
      // Handle errors appropriately (e.g., emit an error state)
      emit(
        NowPlayingError(
          error.toString(),
        ),
      );
    }
  }
}
