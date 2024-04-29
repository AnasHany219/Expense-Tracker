import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/expense.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/repo/parent_date.dart';

class APIsRepo extends ParentRepo {
  // Implementing deleteExpense method for API data source
  @override
  Future<void> deleteExpense({required Comparable<num> id}) {
    // TODO: implement deleteExpense
    // Implement logic to delete expense data using external API
    // Example: Send HTTP DELETE request to API endpoint with expense ID to delete
    throw UnimplementedError();
  }

  // Implementing fetchExpenses method for API data source
  @override
  Future<List<Expense>> fetchExpenses({String? email = ''}) {
    // TODO: implement fetchExpenses
    // Implement logic to fetch expense data from external API
    // Example: Send HTTP GET request to API endpoint to retrieve expense list
    // Parse the response and return a list of Expense objects
    throw UnimplementedError();
  }

  // Implementing insertExpense method for API data source
  @override
  Future<void> insertExpense(Expense expense) {
    // TODO: implement insertExpense
    // Implement logic to insert expense data using external API
    // Example: Send HTTP POST request to API endpoint to add new expense
    throw UnimplementedError();
  }
}
