part of 'top_rated_bloc.dart';

@immutable
sealed class TopRatedEvent {}

class FetchTopRatedEvent extends TopRatedEvent {}
