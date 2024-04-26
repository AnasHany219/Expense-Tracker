

import 'package:expense_tracker/features/dashboard/modules/expenses/model/expense_model.dart';
import 'package:expense_tracker/features/dashboard/modules/expenses/model/repo/parent_data.dart';

class APIsRepo extends ParentData{
  @override
  Future<void> delete({required String id}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<ExpenseModel>> fetch() {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  @override
  Future<void> insert({required String name, required String cost}) {
    // TODO: implement insert
    throw UnimplementedError();
  }
  


}