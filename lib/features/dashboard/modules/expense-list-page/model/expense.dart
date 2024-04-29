class Expense {
  final int id;
  final double amount;
  final String category;
  final String date;
  final String notes;
  final String email;

  Expense({
    required this.id,
    required this.amount,
    required this.category,
    required this.date,
    required this.notes,
    required this.email,
  });

  // Factory constructor to create Expense object from a map
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
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
      'id': id,
      'email': email,
      'amount': amount,
      'category': category,
      'date': date,
      'notes': notes,
    };
  }
}
