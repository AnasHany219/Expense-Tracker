// ignore_for_file: depend_on_referenced_packages

import 'package:expense_tracker/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserDB {
  late Database db;

  UserDB() {
    init();
  }

  /// Initializes the user database.
  ///
  /// This method creates or opens the database file and ensures that the necessary table is created if it doesn't already exist.
  Future<void> init() async {
    try {
      String dbPath = await getDatabasesPath();
      String dbName = 'user_db.db';
      String newPath = join(dbPath, dbName);
      db = await openDatabase(
        newPath,
        version: 1,
        onCreate: _createDatabase,
      );
    } catch (e) {
      throw Exception('Failed to initialize database: $e');
    }
  }

  /// Creates the users table in the database.
  ///
  /// This method is called when the database is created for the first time.
  Future<void> _createDatabase(Database db, int version) async {
    try {
      await db.execute('''
        CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          first_name TEXT,
          last_name TEXT,
          email TEXT,
          password TEXT,
          verified INTEGER DEFAULT 0
        )
      ''');
    } catch (e) {
      throw Exception('Failed to create database: $e');
    }
  }

  /// Inserts a new user into the database.
  ///
  /// This method inserts the specified [user] into the 'users' table in the database. If the operation fails, an exception is thrown.
  Future<void> insertUser(User user) async {
    await init();
    try {
      await db.insert(
        'users',
        user.toMap(),
      );
    } catch (e) {
      throw Exception('Failed to insert user: $e');
    }
  }

  /// Clears all users from the database.
  ///
  /// This method deletes all rows from the 'users' table, effectively clearing the table.
  Future<void> clearUsers() async {
    await init();
    try {
      await db.delete('users');
    } catch (e) {
      throw Exception('Failed to clear users: $e');
    }
  }

  /// Checks if the specified email already exists in the database.
  ///
  /// Returns `true` if the email exists, `false` otherwise.
  Future<bool> checkEmailExists(String email) async {
    await init(); // Ensure database initialization before query
    try {
      // Query the database to check if the email exists
      List<Map<String, dynamic>> existingUsers = await db.query(
        'users',
        where: 'email = ?',
        whereArgs: [email],
      );
      return existingUsers
          .isNotEmpty; // Return true if email exists, false otherwise
    } catch (e) {
      throw Exception('Failed to check if email exists: $e');
    }
  }
}
