// ignore_for_file: depend_on_referenced_packages

import 'package:expense_tracker/features/auth/model/user.dart';
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

  Future<void> updateUserNameByEmail(
      String email, String firstName, String lastName) async {
    await init();
    try {
      await db.transaction((txn) async {
        int count = await txn.rawUpdate(
          'UPDATE users SET first_name = ?, last_name = ? WHERE email = ?',
          [firstName, lastName, email],
        );
        if (count != 1) {
          throw Exception(
            'Failed to update user name: Unexpected number of rows updated',
          );
        }
      });
    } catch (e) {
      throw Exception('Failed to update user name: $e');
    }
  }

  Future<void> updateUserPasswordByEmail(String email, String password) async {
    await init(); // Assuming init() initializes your database connection
    try {
      await db.transaction((txn) async {
        int count = await txn.rawUpdate(
          'UPDATE users SET password = ? WHERE email = ?',
          [password, email],
        );
        if (count != 1) {
          throw Exception(
              'Failed to update user password: Unexpected number of rows updated');
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

  Future<void> deleteUserByEmail(String email) async {
    await init();
    try {
      await db.transaction((txn) async {
        int count = await txn.rawDelete(
          'DELETE FROM users WHERE email = ?',
          [email],
        );
        if (count != 1) {
          throw Exception(
              'Failed to delete user: Unexpected number of rows deleted');
        }
      });
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }
}
