import 'package:advanced_flutter/app/constant.dart';
import 'package:advanced_flutter/data/responses/responses.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  //here _AppServiceCleint will be auto generated
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  //post method of login
  @POST("/customers/login")
  //login method ..its async so use future.. run command it will be auto generated
  //we will receive response
  Future<AuthenticationResponse> login(
    @Field("email") String email,
    @Field("password") String password,
    @Field("imei") String imei,
    @Field("deviceType") String deviceType,
  );
}
