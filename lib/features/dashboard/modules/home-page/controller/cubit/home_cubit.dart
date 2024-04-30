import 'package:bloc/bloc.dart';
import 'package:expense_tracker/features/auth/model/user.dart';
import 'package:expense_tracker/features/auth/provider/user_db.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/expense.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/repo/local_db_data.dart';
import 'package:expense_tracker/features/dashboard/modules/home-page/controller/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeCubit extends Cubit<HomeState> {
  final String? email;
  User? currentUser;
  double userBudget = 0.0;
  List<Expense> expenses = [];
  Map<String, double> expenseSummary = {};
  TextEditingController userBudgetController = TextEditingController();

  HomeCubit(this.email) : super(HomeLoading()) {
    init();
  }

  Future<void> init() async {
    emit(HomeLoading());

    await fetchCurrentUser();
    await fetchExpenses();
    calculateExpenseSummary();

    // Retrieve userBudget from SharedPreferences using the user's email
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = 'userBudget_$email'; // Unique key for each user
    userBudget = prefs.getDouble(key) ?? 0.0;

    emit(currentUser == null ? HomeEmpty() : HomeLoaded(currentUser!));
  }

  Future<void> fetchCurrentUser() async {
    UserDB userDB = UserDB();
    currentUser = await userDB.getUserByEmail(email!);
  }

  Future<void> fetchExpenses() async {
    expenses = await (await DatabaseRepo.instance).fetchExpenses(email: email);
  }

  double calculateTotalExpenses() {
    return expenses.fold(
        0.0, (previousValue, expense) => previousValue + expense.amount);
  }

  void calculateExpenseSummary() {
    expenseSummary.clear();
    for (var expense in expenses) {
      expenseSummary[expense.category] =
          (expenseSummary[expense.category] ?? 0) + expense.amount;
    }
  }

  Map<String, double> getExpenseSummary() {
    return Map<String, double>.from(expenseSummary);
  }

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
