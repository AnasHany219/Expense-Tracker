import 'package:expense_tracker/core/route_generator.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  MaterialApp materialApp = MaterialApp(
    onGenerateRoute: InitialRouteGenerator.onGenerateRoute,
    onGenerateInitialRoutes: (_) => InitialRouteGenerator.initialRoute,
  );

  runApp(materialApp);
}
