import 'package:expense_tracker/core/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load();

  MaterialApp materialApp = MaterialApp(
    onGenerateRoute: InitialRouteGenerator.onGenerateRoute,
    onGenerateInitialRoutes: (_) => InitialRouteGenerator.initialRoute,
  );

  runApp(materialApp);
}
