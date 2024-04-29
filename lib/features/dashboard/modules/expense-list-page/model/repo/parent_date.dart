import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/expense.dart';

abstract class ParentRepo {
  Future<void> insertExpense(Expense expense);
  Future<List<Expense>> fetchExpenses({String? email = ''});
  Future<void> deleteExpense({required String id});
}
