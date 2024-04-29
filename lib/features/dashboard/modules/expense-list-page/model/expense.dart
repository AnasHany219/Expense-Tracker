class Expense {
  String? id;
  final String email;
  final double amount;
  final String category;
  final String date;
  final String notes;

  Expense({
    this.id,
    required this.email,
    required this.amount,
    required this.category,
    required this.date,
    required this.notes,
  });

  // Factory constructor to create Expense object from a map
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'].toString(),
      email: map['email'],
      amount: map['amount'],
      category: map['category'],
      date: map['date'],
      notes: map['notes'],
    );
  }

  // Method to convert Expense object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id != null ? int.tryParse(id!) : null,
      'email': email,
      'amount': amount,
      'category': category,
      'date': date,
      'notes': notes,
    };
  }
}
