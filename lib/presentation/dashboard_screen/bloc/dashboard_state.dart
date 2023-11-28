part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState {}

abstract class DashboardActionState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardError extends DashboardState {
  final String message;

  DashboardError(
    this.message,
  );
}

class DashboardSuccess extends DashboardState {
  final List<Movie> movies;

  DashboardSuccess(
    this.movies,
  );
}

class DashboardSearchButtonNavigateState extends DashboardState
    implements DashboardActionState {}

class NowPlayingState extends DashboardState {}

class NowPlayingLoading extends NowPlayingState {}

class NowPlayingSuccess extends NowPlayingState {
  final List<Movie> nowPlayingMovies;

  NowPlayingSuccess(
    this.nowPlayingMovies,
  );
}

class NowPlayingError extends NowPlayingState {
  final String errorMessage;

  NowPlayingError(
    this.errorMessage,
  );
}

class TopRatedState extends DashboardState {}

class TopRatedLoading extends DashboardState {}

class TopRatedSuccess extends TopRatedState {
  final List<Movie> topRatedMovies;

  TopRatedSuccess(this.topRatedMovies);
}

class TopRatedError extends TopRatedState {
  final String errorMessage;

  TopRatedError(this.errorMessage);
}

class ProfileState extends DashboardState {}
