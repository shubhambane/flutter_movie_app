import 'package:flutter/material.dart';
import 'package:movieflix/presentation/dashboard_screen/bloc/dashboard_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieflix/presentation/dashboard_screen/tabs/now_playing_tab.dart';
import 'package:movieflix/presentation/dashboard_screen/tabs/profile_tab.dart';
import 'package:movieflix/presentation/dashboard_screen/tabs/top_rated_tab.dart';
import 'package:movieflix/routes/app_routes.dart';

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
    dashboardBloc.add(DashboardInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      bloc: dashboardBloc,
      listenWhen: (previous, current) => current is DashboardActionState,
      buildWhen: (previous, current) => current is! DashboardActionState,
      listener: (context, state) {
        if (state is DashboardSearchButtonNavigateState) {
          Navigator.pushNamed(context, AppRoutes.movieInfo);
        } else if (state is DashboardError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        print(state.runtimeType.toString());
        return Scaffold(
          appBar: AppBar(
            title: const Text('MovieFlix'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  dashboardBloc.add(DashboardSearchButtonNavigateEvent());
                },
              )
            ],
          ),
          body: _buildBody(state),
          bottomNavigationBar: _buildBottomNavigationBar(context, state),
        );
      },
    );
  }

  Widget _buildBody(DashboardState state) {
    if (state is DashboardLoading) {
      return Container(
        color: Colors.red,
      );
    } else if (state is DashboardSuccess) {
      return NowPlayingTab();
    } else if (state is NowPlayingState) {
      return NowPlayingTab();
    } else if (state is TopRatedState) {
      return TopRatedTab();
    } else if (state is ProfileState) {
      return ProfileTab();
    } else {
      return Container(
        color: Colors.pink,
      );
    }
  }

  Widget _buildBottomNavigationBar(BuildContext context, DashboardState state) {
    return BottomNavigationBar(
      currentIndex: _currentIndex(state),
      onTap: (index) {
        _handleBottomNavigationTap(context, index);
      },
      items: [
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
    if (state is NowPlayingState) {
      return 0;
    } else if (state is TopRatedState) {
      return 1;
    } else if (state is ProfileState) {
      return 2;
    } else {
      return 0;
    }
  }

  void _handleBottomNavigationTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        dashboardBloc.add(NowPlayingSelectedEvent());
        break;
      case 1:
        dashboardBloc.add(TopRatedSelectedEvent());
        break;
      case 2:
        dashboardBloc.add(ProfileSelectedEvent());
        break;
    }
  }
}
