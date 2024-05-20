/// Class representing an expense entity.
class Expense {
  /// Unique identifier for the expense.
  String? id;

  /// Email address associated with the expense.
  final String email;

  /// Amount of the expense.
  final double amount;

  /// Category of the expense.
  final String category;

  /// Date of the expense.
  final String date;

  /// Additional notes for the expense.
  final String notes;

  /// Constructs a new [Expense] instance.
    Expense({
      this.id,
      required this.email,
      required this.amount,
      required this.category,
      required this.date,
      required this.notes,
  });

  /// Factory constructor to create an Expense object from a map.
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id']?.toString(),
      email: map['email'],
      amount: map['amount'],
      category: map['category'],
      date: map['date'],
      notes: map['notes'],
    );
  }

  /// Method to convert the Expense object to a map.
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
