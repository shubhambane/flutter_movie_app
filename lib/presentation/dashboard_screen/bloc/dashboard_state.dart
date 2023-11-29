part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState {}

abstract class DashboardActionState extends DashboardState {}

final class DashboardInitial extends DashboardState {}

class NavigateToNowPalyingState extends DashboardState {}

class NavigateToTopRatedState extends DashboardActionState {}

class NavigateToProfileState extends DashboardActionState {}

class DashboardSearchButtonNavigateState extends DashboardActionState {}
