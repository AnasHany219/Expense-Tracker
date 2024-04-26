part of 'dashboard_cubit.dart';

@immutable
sealed class DashboardState {}

class DashboardChangeState extends DashboardState {}
final class DashboardInitial extends DashboardState {}
