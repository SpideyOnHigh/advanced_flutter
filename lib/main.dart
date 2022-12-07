import 'package:advanced_flutter/app/di.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';

void main() async{

  //to ensure the init
  WidgetsFlutterBinding.ensureInitialized();

  //dependency injection function
  await initAppModule();

  runApp(MyApp());
}

