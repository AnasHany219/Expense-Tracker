import 'package:bloc/bloc.dart';
import 'package:expense_tracker/features/auth/model/user.dart';
import 'package:expense_tracker/features/auth/provider/user_db.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/expense.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/repo/local_db_data.dart';
import 'package:expense_tracker/features/dashboard/modules/home-page/controller/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A Cubit responsible for managing the state of the home page.
class HomeCubit extends Cubit<HomeState> {
  /// The email address of the current user.
  final String? email;

  /// The current user.
  User? currentUser;

  /// The user's budget.
  double userBudget = 0.0;

  /// The list of expenses.
  List<Expense> expenses = [];

  /// Summary of expenses categorized by category.
  Map<String, double> expenseSummary = {};

  /// Controller for the user budget text field.
  TextEditingController userBudgetController = TextEditingController();

  /// Constructs a new [HomeCubit] instance.
  HomeCubit(this.email) : super(HomeLoading()) {
    init();
  }

  /// Initializes the home cubit.
  Future<void> init() async {
    emit(HomeLoading());

    await fetchCurrentUser();
    await fetchExpenses();
    calculateExpenseSummary();
    await loadUserBudgetFromSharedPreferences();

    emit(currentUser == null ? HomeEmpty() : HomeLoaded(currentUser!));
  }

  /// Fetches the current user from the database.
  Future<void> fetchCurrentUser() async {
    UserDB userDB = UserDB();
    currentUser = await userDB.getUserByEmail(email!);
  }

  /// Fetches the expenses of the current user.
  Future<void> fetchExpenses() async {
    expenses = await (await DatabaseRepo.instance).fetchExpenses(email: email);
  }

  /// Calculates the total expenses of the user.
  double calculateTotalExpenses() {
    return expenses.fold(
        0.0, (previousValue, expense) => previousValue + expense.amount);
  }

  /// Calculates the summary of expenses categorized by category.
  void calculateExpenseSummary() {
    expenseSummary.clear();
    for (var expense in expenses) {
      expenseSummary[expense.category] =
          (expenseSummary[expense.category] ?? 0) + expense.amount;
    }
  }

  /// Retrieves the expense summary.
  Map<String, double> getExpenseSummary() {
    return Map<String, double>.from(expenseSummary);
  }

  /// Loads the user budget from SharedPreferences.
  Future<void> loadUserBudgetFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = 'userBudget_$email'; // Unique key for each user
    userBudget = prefs.getDouble(key) ?? 0.0;
  }

  /// Updates the user budget.
  void updateUserBudget(double newBudget) async {
    // Update the local userBudget variable
    userBudget = newBudget;

    // Save the updated userBudget to SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = 'userBudget_$email'; // Unique key for each user
    await prefs.setDouble(key, newBudget);

    // Emit a state to notify listeners about the budget update
    emit(HomeLoaded(currentUser!));
  }
}
