import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "parent_state.dart";

class ParentCubit extends Cubit<ParentState> {
  static final ParentCubit instance = ParentCubit();

  Map<String, dynamic> local = {};
  ThemeMode themeMode = ThemeMode.light;
  String language = 'en';
  ParentCubit() : super(ParentInitial()) {
    loadLanguage();
  }
  Future<void> loadLanguage() async {
    String s = await rootBundle.loadString('assets/lang/$language.json');
    local = await json.decode(s);
    emit(ParentInitial());
  }

  void changeMode() {
    themeMode = themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    emit(ParentInitial());
  }

  void changeLang() {
    language = language == 'ar' ? 'en' : 'ar';
    loadLanguage();
    emit(ParentInitial());
  }
}
