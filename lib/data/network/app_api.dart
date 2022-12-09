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

  //post method for forgot pass
  @POST("/customers/forgotpass")
  Future<ForgotPassEmailResponse> forgotPass(
    @Field("email") String email,
  );

  //post method for register
  @POST("/customers/register")
  Future<AuthenticationResponse> register(
    @Field("country_mobile_code") String countryMobileCode,
    @Field("username") String username,
    @Field("email") String email,
    @Field("password") String password,
    @Field("mobile_number") String mobileNumber,
    @Field("profile_picture") String profilePicture,
  );
}


