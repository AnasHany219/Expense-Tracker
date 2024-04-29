import 'package:bloc/bloc.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/expense.dart';
// import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/repo/firebase_data.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/repo/local_db_data.dart';
import 'package:meta/meta.dart';

part 'expense_list_state.dart';

class ExpenseListCubit extends Cubit<ExpenseListState> {
  final String? email;
  List<Expense> expenses = []; // List variable to store expenses

  ExpenseListCubit(this.email) : super(ExpenseListLoading()) {
    init();
  }

  Future<void> init() async {
    emit(ExpenseListLoading());
    expenses = await (await DatabaseRepo.instance).fetchExpenses(email: email);
    // expenses = await FirebaseRepo.instance.fetchExpenses(email: email);

    emit(expenses.isEmpty ? ExpenseListEmpty() : ExpenseListLoaded());
  }
}
