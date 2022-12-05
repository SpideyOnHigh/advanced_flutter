import 'package:advanced_flutter/app/app_prefs.dart';
import 'package:advanced_flutter/app/constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON ="application/json";
const String CONTENT_TYPE ="content_type";
const String ACCEPT ="accept";
const String AUTHORIZATION ="authorization";
const String DEFAULT_LANGUAGE ="language";

class DioFactory{

  late AppPreferences _appPreferences;
  DioFactory(this._appPreferences);

  Future<Dio> getDio() async{
    Dio dio = Dio();

    int _timeOut = 60 * 1000; //1 minute

    Map<String,String> headers = {
      CONTENT_TYPE : APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION : Constant.token,
      DEFAULT_LANGUAGE: await _appPreferences.getAppLanguage()

    };

    dio.options = BaseOptions(
      baseUrl: Constant.baseUrl,
      connectTimeout: _timeOut,
      receiveTimeout: _timeOut,
      headers: headers
    );

    //CHECK THE LOGS TO SEE API REQUEST/RESPONSE
    //if checker to see if we are in release mode or debug mode
    if(kReleaseMode){
      print("Release Mode So No Logs");
    }

    else{
      dio.interceptors.add(PrettyDioLogger(
        requestBody : true,
        responseHeader : true,
        responseBody : true,
      ));
    }

    return dio;


  }
}