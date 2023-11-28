// lib/presentation/dashboard/views/top_rated_tab.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieflix/presentation/dashboard_screen/bloc/dashboard_bloc.dart';

class TopRatedTab extends StatelessWidget {
  const TopRatedTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is TopRatedSuccess) {
          return _buildTopRatedContent(context, state);
        } else if (state is TopRatedError) {
          return Text(state.errorMessage);
        } else {
          return Container(
            color: Colors.yellow, // Placeholder color
          );
        }
      },
    );
  }

  Widget _buildTopRatedContent(BuildContext context, TopRatedSuccess state) {
    if (state is TopRatedLoading) {
      return const CircularProgressIndicator();
    } else {
      return ListView.builder(
        itemCount: state.topRatedMovies.length,
        itemBuilder: (context, index) {
          final movie = state.topRatedMovies[index];
          return ListTile(
            title: Text(movie.title),
            // Other movie details...
          );
        },
      );
    }
  }
}
