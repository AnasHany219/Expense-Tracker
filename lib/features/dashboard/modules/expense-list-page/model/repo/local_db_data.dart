import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/expense.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/repo/parent_date.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Repository class for managing expenses in a local SQLite database.
class DatabaseRepo extends ParentRepo {
  /// Private constructor to prevent direct instantiation.
  DatabaseRepo._init();

  /// Singleton instance of [DatabaseRepo].
  static DatabaseRepo? _singletonObject;

  /// SQLite database instance.
  static late Database _database;

  /// Gets the singleton instance of [DatabaseRepo].
  static Future<DatabaseRepo> get instance async {
    if (_singletonObject == null) {
      await _initDatabase();
      _singletonObject = DatabaseRepo._init();
    }
    return _singletonObject!;
  }

  /// Initializes the SQLite database.
  static Future<void> _initDatabase() async {
    // Get the path to the database file
    final String databasePath = await getDatabasesPath();
    final String path = join(databasePath, 'expenses.db');

    // Open the database
    _database = await openDatabase(path, version: 1, onCreate: _createTable);
  }

  /// Creates the expenses table in the database.
  static Future<void> _createTable(Database db, int version) async {
    // Create the expenses table if it doesn't exist
    await db.execute('''
      CREATE TABLE expenses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT,
        amount DOUBLE,
        category TEXT,
        date TEXT,
        notes TEXT
      )
    ''');
  }

  @override
  Future<void> deleteExpense({required String id}) async {
    await _database
        .delete('expenses', where: 'id = ?', whereArgs: [int.tryParse(id)]);
  }

  @override
  Future<List<Expense>> fetchExpenses({String? email = ''}) async {
    // Query the expenses table
    final List<Map<String, dynamic>> records = await _database.query(
      'expenses',
      where: 'email = ?',
      whereArgs: [email],
    );

    // Map the records to Expense objects
    final List<Expense> expenses =
        records.map((record) => Expense.fromMap(record)).toList();

    return expenses;
  }

  @override
  Future<void> insertExpense(Expense expense) async {
    // Execute the INSERT query
    await _database.insert('expenses', expense.toMap());
  }

  Future<void> deleteExpensesByEmail(String email) async {
    // Delete all expenses associated with the specified email
    await _database.delete('expenses', where: 'email = ?', whereArgs: [email]);
  }
}
