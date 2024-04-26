

import 'package:expense_tracker/features/dashboard/controller/cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardController extends Cubit<DashboardState> {
  DashboardController():super(DashboardChangeState());

  int selectedTapIndex=0;
  final PageController pageController= PageController();

  void onChangeTapIndex(int index){
      selectedTapIndex=index;
      pageController.jumpToPage(selectedTapIndex);
      emit(DashboardChangeState());
  }
}