import 'package:expense_tracker/features/auth/signup/model/user.dart';

sealed class HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final User user;

  HomeLoaded(this.user);
}

class HomeEmpty extends HomeState {}
