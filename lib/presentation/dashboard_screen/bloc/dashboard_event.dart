part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {}

class NavigateToNowPlayingEvent extends DashboardEvent {}

class NavigateToTopRatedEvent extends DashboardEvent {}

class NavigateToProfileEvent extends DashboardEvent {}
