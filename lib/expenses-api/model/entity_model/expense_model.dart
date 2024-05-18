// To parse this JSON data, do
//
//     final expenseModel = expenseModelFromJson(jsonString);

import 'dart:convert';

ExpenseModel expenseModelFromJson(String str) =>
    ExpenseModel.fromJson(json.decode(str));

String expenseModelToJson(ExpenseModel data) => json.encode(data.toJson());

class ExpenseModel {
  final String? id;
  final String? email;
  final String? amount;
  final String? category;
  final String? date;
  final String? notes;

  ExpenseModel({
    this.id,
    this.email,
    this.amount,
    this.category,
    this.date,
    this.notes,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
        id: json["id"],
        email: json["email"],
        amount: json["amount"],
        category: json["category"],
        date: json["date"],
        notes: json["notes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "amount": amount,
        "category": category,
        "date": date,
        "notes": notes,
      };
}
