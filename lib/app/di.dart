import 'package:advanced_flutter/app/app_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async{
  final sharedPrefs = await SharedPreferences.getInstance();

  //shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  //app prefs instance
  //its directly getting we dont have to provide anything else(like instance)
  instance.registerLazySingleton(() => AppPreferences(instance()));

}