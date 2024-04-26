import 'package:expense_tracker/features/dashboard/modules/expenses/model/expense_model.dart';
import 'package:expense_tracker/features/dashboard/modules/expenses/model/repo/local_db_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part "expense_state.dart";

class ExpenseCubit extends Cubit<expenseState> {
  ExpenseCubit() : super(expenseLoading()){
      init();
  }

  List<ExpenseModel> expenses= [];
  Future<void> init () async{
    emit(expenseLoading());
    expenses = await (await DatabaseRepo.instance).fetch();


    if(expenses.isEmpty){
      emit(expenseEmpty());
    }else {
      emit(expenseLoaded());
    }
  }
}