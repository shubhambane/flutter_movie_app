import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movieflix/data/models/movie.dart';
import 'package:movieflix/repository/movie_repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<NavigateToNowPalyingEvent>(navigateToNowPalyingEvent);
    on<NavigateToTopRatedEvent>(navigateToTopRatedEvent);
    on<NavigateToProfileEvent>(navigateToProfileEvent);
  }

  FutureOr<void> navigateToNowPalyingEvent(
      NavigateToNowPalyingEvent event, Emitter<DashboardState> emit) {
    emit(NavigateToNowPalyingState());
  }

  FutureOr<void> navigateToTopRatedEvent(
      NavigateToTopRatedEvent event, Emitter<DashboardState> emit) {
    emit(NavigateToTopRatedState());
  }

  FutureOr<void> navigateToProfileEvent(
      NavigateToProfileEvent event, Emitter<DashboardState> emit) {
    emit(NavigateToProfileState());
  }
}
