import 'package:expense_tracker/core/route_generator.dart';
// import 'package:expense_tracker/provider/user_db.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // WidgetsFlutterBinding
  //     .ensureInitialized(); // Ensure Flutter binding is initialized
  // // Initialize the user database
  // UserDB uDB = UserDB();
  // await uDB.init();
  // // Clear users from the database
  // await uDB.clearUsers();

  MaterialApp materialApp = MaterialApp(
    onGenerateRoute: InitialRouteGenerator.onGenerateRoute,
    onGenerateInitialRoutes: (_) => InitialRouteGenerator.initialRoute,
  );

  runApp(materialApp);
}
