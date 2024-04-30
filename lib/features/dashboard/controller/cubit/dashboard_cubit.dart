import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'dashboard_state.dart';

/// Cubit responsible for managing the dashboard state.
class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardChangeState());

  /// Index of the currently selected tab.
  int selectedTabIndex = 0;

  /// Controller for managing pages in the dashboard.
  final PageController pageController = PageController();

  /// Changes the selected tab index and updates the state.
  void onChangeTabIndex(int index) {
    selectedTabIndex = index;
    pageController.jumpToPage(selectedTabIndex);
    emit(DashboardChangeState());
  }
}
