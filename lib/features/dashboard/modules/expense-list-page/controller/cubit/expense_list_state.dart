part of 'expense_list_cubit.dart';

@immutable
sealed class ExpenseListState {}

final class ExpenseListLoading extends ExpenseListState {}

final class ExpenseListLoaded extends ExpenseListState {}

final class ExpenseListEmpty extends ExpenseListState {}
