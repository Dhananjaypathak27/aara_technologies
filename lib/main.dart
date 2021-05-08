import 'package:aara_technologies/screen/dashboard_screen.dart';
import 'package:aara_technologies/screen/google_map_screen.dart';
import 'package:aara_technologies/screen/recipe_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xFF2874F0)
      ),
      routes: {
        '/': (context) => DashboardScreen(),
        '/dashboard_screen': (context) => DashboardScreen(),
        '/recipe_screen': (context) => RecipeScreen(),
        '/google_map_screen': (context) => GoogleMapScreen(),
      },
    );
  }
}
