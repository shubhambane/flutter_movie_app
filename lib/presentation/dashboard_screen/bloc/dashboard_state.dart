part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState {}

abstract class DashboardActionState extends DashboardState {}

final class DashboardInitial extends DashboardState {}

class NavigateToNowPlayingState extends DashboardState {}

class NavigateToTopRatedState extends DashboardState {}

class NavigateToProfileState extends DashboardState {}
