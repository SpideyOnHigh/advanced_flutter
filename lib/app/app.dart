import 'package:advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

import '../presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {

  int no = 1;

  MyApp._internal(); //private named constructor

  static final instance = MyApp._internal();

  factory MyApp() => instance; //singleton instance

  State<MyApp> createState() => _MyAppState();
}


  @override
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.splashRoute,
      onGenerateRoute: RouteGenerator.getRoute,
      theme: getApplicationTheme(),
    );
  }
}
