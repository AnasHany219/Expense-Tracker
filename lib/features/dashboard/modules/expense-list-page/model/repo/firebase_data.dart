import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/expense.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/repo/parent_date.dart';

class FirebaseRepo extends ParentRepo {
  static FirebaseRepo? _singletonObject;

  FirebaseRepo._init();

  static FirebaseRepo get instance {
    _singletonObject ??= FirebaseRepo._init();
    return _singletonObject!;
  }

  // Implementing deleteExpense method for Firebase data source
  @override
  Future<void> deleteExpense({required Comparable<num> id}) {
    // TODO: implement deleteExpense
    // Implement logic to delete expense data using Firebase services
    // Example: Delete expense document from Firestore collection
    throw UnimplementedError();
  }

  // Implementing fetchExpenses method for Firebase data source
  @override
  Future<List<Expense>> fetchExpenses({String? email = ''}) {
    // TODO: implement fetchExpenses
    // Implement logic to fetch expense data from Firebase services
    // Example: Retrieve expense documents from Firestore collection
    // Parse the documents and return a list of Expense objects
    throw UnimplementedError();
  }

  // Implementing insertExpense method for Firebase data source
  @override
  Future<void> insertExpense(Expense expense) {
    // TODO: implement insertExpense
    // Implement logic to insert expense data using Firebase services
    // Example: Add expense document to Firestore collection
    throw UnimplementedError();
  }
}
