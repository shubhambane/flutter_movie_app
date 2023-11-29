part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {}

class NavigateToNowPalyingEvent extends DashboardEvent {}

class DashboardSearchButtonEvent extends DashboardEvent {}

class NavigateToTopRatedEvent extends DashboardEvent {}

class NavigateToProfileEvent extends DashboardEvent {}
