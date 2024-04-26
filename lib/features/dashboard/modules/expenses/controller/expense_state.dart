part of  "expense_cubit.dart";
@immutable
sealed class expenseState {}

final class expenseLoading extends expenseState {}

final class expenseLoaded extends expenseState {}

final class expenseEmpty extends expenseState {}
