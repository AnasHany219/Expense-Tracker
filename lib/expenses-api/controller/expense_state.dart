part of "expense_cubit.dart";

@immutable
sealed class ExpenseState {}

final class ExpenseLoading extends ExpenseState {}

final class ExpenseLoaded extends ExpenseState {}

final class ExpenseEmpty extends ExpenseState {}
