import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<NavigateToNowPlayingEvent>(navigateToNowPlayingEvent);
    on<NavigateToTopRatedEvent>(navigateToTopRatedEvent);
    on<NavigateToProfileEvent>(navigateToProfileEvent);
  }

  FutureOr<void> navigateToNowPlayingEvent(
      NavigateToNowPlayingEvent event, Emitter<DashboardState> emit) {
    emit(NavigateToNowPlayingState());
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
