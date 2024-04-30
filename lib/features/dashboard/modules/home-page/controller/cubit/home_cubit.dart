import 'package:bloc/bloc.dart';
import 'package:expense_tracker/features/auth/model/user.dart';
import 'package:expense_tracker/features/auth/provider/user_db.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/expense.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/repo/local_db_data.dart';
import 'package:expense_tracker/features/dashboard/modules/home-page/controller/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final String? email;
  User? currentUser;
  List<Expense> expenses = [];

  HomeCubit(this.email) : super(HomeLoading()) {
    init();
  }

  Future<void> init() async {
    emit(HomeLoading());

    UserDB userDB = UserDB();
    currentUser = await userDB.getUserByEmail(email!);

    expenses = await (await DatabaseRepo.instance).fetchExpenses(email: email);

    emit(currentUser == null ? HomeEmpty() : HomeLoaded(currentUser!));
  }

  double calculateTotalExpenses() {
    return expenses.fold(
        0.0, (previousValue, expense) => previousValue + expense.amount);
  }
}
