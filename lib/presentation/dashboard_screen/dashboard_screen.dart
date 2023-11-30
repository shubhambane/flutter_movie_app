import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movieflix/presentation/dashboard_screen/bloc/dashboard_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieflix/presentation/dashboard_screen/tabs/profile_tab.dart';
import 'package:movieflix/presentation/now_playing/now_playing_page.dart';
import 'package:movieflix/presentation/top_rated/top_rated_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardBloc dashboardBloc = DashboardBloc();

  @override
  void initState() {
    super.initState();
    dashboardBloc = DashboardBloc();
    dashboardBloc.add(NavigateToNowPlayingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      bloc: dashboardBloc,
      listenWhen: (previous, current) => current is DashboardActionState,
      buildWhen: (previous, current) => current is! DashboardActionState,
      listener: (context, state) {},
      builder: (context, state) {
        if (kDebugMode) {
          print(state.runtimeType.toString());
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('MovieFlix'),
          ),
          body: _buildBody(state),
          bottomNavigationBar: _buildBottomNavigationBar(context, state),
        );
      },
    );
  }

  Widget _buildBody(DashboardState state) {
    switch (state.runtimeType) {
      case NavigateToNowPlayingState:
        return const NowPlayingTab();
      case NavigateToTopRatedState:
        return const TopRatedPage();
      case NavigateToProfileState:
        return const ProfileTab();
      default:
        return Container(
          color: Colors.purple,
        );
    }
  }

  Widget _buildBottomNavigationBar(BuildContext context, DashboardState state) {
    return BottomNavigationBar(
      currentIndex: _currentIndex(state),
      onTap: (index) {
        _handleBottomNavigationTap(context, index);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.play_arrow),
          label: 'Now Playing',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          label: 'Top Rated',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }

  int _currentIndex(DashboardState state) {
    if (state is NavigateToNowPlayingState) {
      return 0;
    } else if (state is NavigateToTopRatedState) {
      return 1;
    } else if (state is NavigateToProfileState) {
      return 2;
    } else {
      return 0;
    }
  }

  void _handleBottomNavigationTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        dashboardBloc.add(NavigateToNowPlayingEvent());
        break;
      case 1:
        dashboardBloc.add(NavigateToTopRatedEvent());
        break;
      case 2:
        dashboardBloc.add(NavigateToProfileEvent());
        break;
    }
  }
}
