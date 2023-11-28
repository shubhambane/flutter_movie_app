part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {}

class DashboardInitialEvent extends DashboardEvent {}

class DashboardSearchButtonNavigateEvent extends DashboardEvent {}

class DashboardFetchNowPlaying extends DashboardEvent {}

class DashboardFetchTopRated extends DashboardEvent {}

class NowPlayingSelectedEvent extends DashboardEvent {}

class TopRatedSelectedEvent extends DashboardEvent {}

class ProfileSelectedEvent extends DashboardEvent {}

class NowPlayingSuccessEvent extends DashboardEvent {
  final List<Movie> nowPlayingMovies;

  NowPlayingSuccessEvent(this.nowPlayingMovies);
}

class NowPlayingErrorEvent extends DashboardEvent {
  final String errorMessage;

  NowPlayingErrorEvent(this.errorMessage);
}
