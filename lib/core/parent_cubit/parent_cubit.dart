import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "parent_state.dart";

class ParentCubit extends Cubit<ParentState> {
  static final ParentCubit instance = ParentCubit();

  ParentCubit() : super(ParentInitial()) {
    loadLanguage();
  }
  Map<String, dynamic> local = {};

  Future<void> loadLanguage() async {
    String s = await rootBundle.loadString('assets/lang/ar.json');
    local = await json.decode(s);
    emit(ParentInitial());
  }
}
