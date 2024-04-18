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
          verified INTEGER DEFAULT 0,
          otpCode TEXT
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

  /// Retrieves user data from the database by the specified ID.
  ///
  /// This method queries the database for a user with the given [id].
  Future<User?> getUserById(int id) async {
    await init(); // Ensure database initialization before query
    try {
      List<Map<String, dynamic>> userData = await db.query(
        'users',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (userData.isNotEmpty) {
        return User.fromMap(userData.first);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Failed to get user by ID: $e');
    }
  }

  /// Retrieves a user from the database by their email.
  ///
  /// This method queries the database to retrieve a user with the specified [email].
  Future<User?> getUserByEmail(String email) async {
    await init();
    try {
      List<Map<String, dynamic>> userData = await db.query(
        'users',
        where: 'email = ?',
        whereArgs: [email],
      );
      if (userData.isNotEmpty) {
        return User.fromMap(userData.first);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Failed to get user by email: $e');
    }
  }

  Future<String?> getOTPByEmail(String email) async {
    await init(); // Assuming init() initializes your database connection
    try {
      List<Map<String, dynamic>> result = await db.query(
        'users',
        columns: ['otpCode'],
        where: 'email = ?',
        whereArgs: [email],
      );
      if (result.isNotEmpty) {
        return result.first['otpCode'];
      } else {
        return null; // No user found with the given email
      }
    } catch (e) {
      throw Exception('Failed to get user OTP: $e');
    }
  }

  /// Updates the OTP code for a specific user in the database.
  ///
  /// This method updates the `otpCode` field for the user with the specified [email] in the 'users' table of the database.
  Future<void> updateUserOTPByEmail(String email, String otpCode) async {
    await init(); // Assuming init() initializes your database connection
    try {
      await db.transaction((txn) async {
        int count = await txn.rawUpdate(
          'UPDATE users SET otpCode = ? WHERE email = ?',
          [otpCode, email],
        );
        if (count != 1) {
          throw Exception(
              'Failed to update user OTP: Unexpected number of rows updated');
        }
      });
    } catch (e) {
      throw Exception('Failed to update user OTP: $e');
    }
  }

  /// Updates the verification status for a specific user in the database.
  ///
  /// This method updates the `verified` field for the user with the specified [email] in the 'users' table of the database.
  Future<void> updateUserVerificationStatus(
      String email, int verifiedStatus) async {
    await init();
    try {
      await db.update(
        'users',
        {'verified': verifiedStatus},
        where: 'email = ?',
        whereArgs: [email],
      );
    } catch (e) {
      throw Exception('Failed to update user verification status: $e');
    }
  }
}
