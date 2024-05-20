import 'package:bloc/bloc.dart';
import 'package:expense_tracker/expenses-api/model/entity_model/expense_model.dart';
import 'package:expense_tracker/expenses-api/model/repo/expense_api_repo.dart';
import 'package:flutter/material.dart';
part "expense_state.dart";

class ExpenseCubit extends Cubit<ExpenseState> {
  ExpenseCubit() : super(ExpenseLoading());
  List<ExpenseModel> items = [];
  final ExpenseAPIRepo _repo = ExpenseAPIRepo();
  Future<void> init() async {
    emit(ExpenseLoading());
    items = await _repo.fetchExpenses();
    if (items.isEmpty) {
      emit(ExpenseEmpty());
    }else{
      emit(ExpenseLoaded());
    }
  }
}
