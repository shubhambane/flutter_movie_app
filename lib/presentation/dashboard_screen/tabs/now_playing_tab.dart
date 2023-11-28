// lib/presentation/dashboard/views/now_playing_tab.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieflix/presentation/dashboard_screen/bloc/dashboard_bloc.dart';

class NowPlayingTab extends StatelessWidget {
  const NowPlayingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is NowPlayingLoading) {
          return _buildLoadingIndicator();
        } else if (state is NowPlayingSuccess) {
          return _buildNowPlayingContent(context, state);
        } else if (state is NowPlayingError) {
          return Text(state.errorMessage);
        } else {
          return Container(
            color: Colors.purple,
          );
        }
      },
    );
  }

  Widget _buildNowPlayingContent(
      BuildContext context, NowPlayingSuccess state) {
    return ListView.builder(
      itemCount: state.nowPlayingMovies.length,
      itemBuilder: (context, index) {
        final movie = state.nowPlayingMovies[index];

        return ListTile(
          title: Text(movie.title),
          // Other movie details...
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
