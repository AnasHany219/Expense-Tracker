import 'package:dio/dio.dart';
import 'package:expense_tracker/expenses-api/model/entity_model/expense_model.dart';

class ExpenseAPIRepo {
  Dio _dio = Dio();

  String baseUrl = "";
  Future<List<ExpenseModel>> fetchUsers() async {
    Response<List<dynamic>> res = await _dio.get(baseUrl + 'items');

    return res.data!.map((e) => ExpenseModel.fromJson(e)).toList();
  }
}
