


import 'package:expense_tracker/features/dashboard/modules/expenses/model/expense_model.dart';

abstract class ParentData{
  Future<void> insert({required String name, required String cost});
  Future<List<ExpenseModel>> fetch();
  Future<void> delete({required String id});
}