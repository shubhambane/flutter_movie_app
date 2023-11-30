part of 'top_rated_bloc.dart';

@immutable
sealed class TopRatedState {}

class TopRatedActionState extends TopRatedState {}

final class TopRatedInitial extends TopRatedState {}

final class TopRatedLoading extends TopRatedState {}

final class TopRatedSuccess extends TopRatedState {
  final List<Movie> topRatedMovies;

  TopRatedSuccess(this.topRatedMovies);
}

final class TopRatedError extends TopRatedState {
  final String errorMessage;

  TopRatedError(this.errorMessage);
}
