import 'package:expense_tracker/features/dashboard/modules/expenses/model/expense_model.dart';
import 'package:expense_tracker/features/dashboard/modules/expenses/model/repo/parent_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseRepo extends ParentData {
  static DatabaseRepo? _singletoneObject;
  static late Database _database;
  DatabaseRepo._init();

  static Future<DatabaseRepo> get instance async {
    if (_singletoneObject == null) {
      await _initDatabase();
      _singletoneObject = DatabaseRepo._init();
    }
    return _singletoneObject!;
  }

  static Future<void> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'expenses.db');

    _database = await openDatabase(path, version: 1, onCreate: createTables);
  }

  static Future<void> createTables(Database db, _) async {
    await db.execute("""
    CREATE TABLE expense(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      cost INTEGER NOT NULL
    )
    
    """);
  }

  @override
  Future<void> delete({required String id}) async {
    await _database.delete('expense', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<ExpenseModel>> fetch() async {
    return (await _database.query('expense'))
        .map((e) => ExpenseModel.fromJson(e))
        .toList();
  }

  @override
  Future<void> insert({required String name, required String cost}) async {
    await _database.insert(
      'expense',
      {'name': name, 'cost': int.parse(cost)},
    );
  }
}
