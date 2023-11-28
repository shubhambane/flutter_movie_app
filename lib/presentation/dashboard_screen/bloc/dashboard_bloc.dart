import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movieflix/data/models/movie.dart';
import 'package:movieflix/repository/movie_repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final MovieRepository _movieRepository = MovieRepository();

  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardInitialEvent>(dashboardInitialEvent);
    on<DashboardSearchButtonNavigateEvent>(dashboardSearchButtonNavigateEvent);
    on<NowPlayingSelectedEvent>(nowPlayingSelectedEvent);
    on<TopRatedSelectedEvent>(topRatedSelectedEvent);
    on<ProfileSelectedEvent>(profileSelectedEvent);
  }

  Future<void> dashboardInitialEvent(
    DashboardInitialEvent event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      emit(DashboardLoading());

      // Fetch data from the API using the repository
      final List<Movie> movies = await _movieRepository.fetchNowPlayingMovies();
      emit(NowPlayingSuccess(movies));
      print('now playing movies fetched');
  
      // print(movies[0].title);
    } catch (error) {
      // Handle errors appropriately (e.g., emit an error state)
      emit(
        DashboardError(
          error.toString(),
        ),
      );
    }
  }

  void dashboardSearchButtonNavigateEvent(
      DashboardSearchButtonNavigateEvent event, Emitter<DashboardState> emit) {
    print('thik hai bhaya');
    emit(DashboardSearchButtonNavigateState());
  }

  void nowPlayingSelectedEvent(
    NowPlayingSelectedEvent event,
    Emitter<DashboardState> emit,
  ) {
    emit(NowPlayingState());
  }

  void topRatedSelectedEvent(
    TopRatedSelectedEvent event,
    Emitter<DashboardState> emit,
  ) {
    emit(TopRatedState());
  }

  void profileSelectedEvent(
    ProfileSelectedEvent event,
    Emitter<DashboardState> emit,
  ) {
    emit(ProfileState());
  }
}
