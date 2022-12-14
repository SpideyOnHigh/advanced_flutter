import 'package:advanced_flutter/app/app_prefs.dart';
import 'package:advanced_flutter/data/data_source/remote_data_source.dart';
import 'package:advanced_flutter/data/network/app_api.dart';
import 'package:advanced_flutter/data/network/dio_factory.dart';
import 'package:advanced_flutter/data/network/network_info.dart';
import 'package:advanced_flutter/data/repository/repository_impl.dart';
import 'package:advanced_flutter/domain/repository/repository.dart';
import 'package:advanced_flutter/domain/usecase/forgot_pass_usecase.dart';
import 'package:advanced_flutter/domain/usecase/login_usecase.dart';
import 'package:advanced_flutter/presentation/forgot_password/forgot_password_viewmodel.dart';
import 'package:advanced_flutter/presentation/login/login_viewmodel.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async{

  //initializing of sharedPref sometimes cause NullPointerException (so we have added 1 line in main.dart)
  final sharedPrefs = await SharedPreferences.getInstance();

  //shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  //app prefs instance
  //its directly getting we don't have to provide anything else(like instance)
  instance.registerLazySingleton(() => AppPreferences(instance()));
  
  
  //network info
  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(DataConnectionChecker()));

  //dio factory
  //we are passing instance() here because we already have registered AppPreference to Getit
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  //app service client
  //we have instance of diofactory but we need Dio so init.
  final Dio dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  //remote data source
  instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImplementer(instance()));

  //repository
  instance.registerLazySingleton<Repository>(() => RepositoryImpl(instance(), instance()));

}
//confusion between lazyinstance and factory ??
// Singleton means one instance per the project, so we are going to use it many times in many places,
// for example shared preferences we need the instance in many places so its better to make it single tone,
//     and factory means when I call the instance so create new instance of this class,
// let's say we have login use case so we only use it inside login page so no need to create singlton '
// 'so we will use provider which means provide a new instance when we need the instance,


initLoginModule(){
  //we are registering as Factory so everytime we get new instance of it.
  //checking the instance is registered or not
  if(!GetIt.I.isRegistered<LoginUseCase>()){
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }

  if(!GetIt.I.isRegistered<ForgotPassUseCase>()){
    instance.registerFactory<ForgotPassUseCase>(() => ForgotPassUseCase(instance()));
    instance.registerFactory<ForgotPasswordViewModel>(() => ForgotPasswordViewModel(instance()));
  }
}