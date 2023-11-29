part of 'now_playing_bloc.dart';

@immutable
sealed class NowPlayingState {}

class NowPlayingActionState extends NowPlayingState {}

class NowPlayingInitial extends NowPlayingState {}

class NowPlayingLoading extends NowPlayingState {}

class NowPlayingSuccess extends NowPlayingState {
  final List<Movie> nowPlayingMovies;

  NowPlayingSuccess(this.nowPlayingMovies);
}

class NowPlayingError extends NowPlayingState {
  final String errorMessage;

  NowPlayingError(this.errorMessage);
}
