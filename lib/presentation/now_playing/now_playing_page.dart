// lib/presentation/dashboard/views/now_playing_tab.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieflix/presentation/dashboard_screen/bloc/dashboard_bloc.dart';
import 'package:movieflix/presentation/now_playing/bloc/now_playing_bloc.dart';

class NowPlayingTab extends StatefulWidget {
  const NowPlayingTab({super.key});

  @override
  State<NowPlayingTab> createState() => _NowPlayingTabState();
}

class _NowPlayingTabState extends State<NowPlayingTab> {
  final NowPlayingBloc nowPlayingBloc = NowPlayingBloc();
  @override
  void initState() {
    super.initState();

    nowPlayingBloc.add(FetchNowPlayingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NowPlayingBloc, NowPlayingState>(
      bloc: nowPlayingBloc,
      listenWhen: (previous, current) => current is NowPlayingActionState,
      buildWhen: (previous, current) => current is! NowPlayingActionState,
      listener: (BuildContext context, NowPlayingState state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case NowPlayingLoading:
            return _buildLoadingIndicator();

          case NowPlayingSuccess:
            final successState = state as NowPlayingSuccess;
            return _buildNowPlayingContent(context, successState);

          case NowPlayingError:
            final errorState = state as NowPlayingError;
            return Text(errorState.errorMessage);

          default:
            return Container(
              color: Colors.purple,
            );

          // if (state is NowPlayingLoading) {
          //   return _buildLoadingIndicator();
          // } else if (state is NowPlayingSuccess) {
          //   return _buildNowPlayingContent(context, state);
          // } else if (state is NowPlayingError) {
          //   return Text(state.errorMessage);
          // } else {
          //   return Container(
          //     color: Colors.purple,
          //   );
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
