import 'package:expense_tracker/features/dashboard/modules/expenses/model/expense_model.dart';
import 'package:expense_tracker/features/dashboard/modules/expenses/model/repo/parent_data.dart';

class FirebaseRepo extends ParentData {
  static FirebaseRepo? _singletoneObject;

  FirebaseRepo._init();

  static FirebaseRepo get instance {
    if (_singletoneObject == null) {
      _singletoneObject = FirebaseRepo._init();
    }
    return _singletoneObject!;
  }

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
