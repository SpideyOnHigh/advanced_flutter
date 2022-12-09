import 'package:advanced_flutter/data/network/app_api.dart';
import 'package:advanced_flutter/data/request/request.dart';
import 'package:advanced_flutter/data/responses/responses.dart';

abstract class RemoteDataSource{
   Future<AuthenticationResponse> login(LoginRequest loginRequest);
   //as we have only one param we don't need to create Request class
   //here i have created for understanding
   Future<ForgotPassEmailResponse> forgotPass(ForgotPassRequest forgotPassRequest);

   Future<AuthenticationResponse> register(RegisterRequest registerRequest);
}

class RemoteDataSourceImplementer implements RemoteDataSource{

  AppServiceClient _appServiceClient;
  RemoteDataSourceImplementer(this._appServiceClient);
  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async{
    return await _appServiceClient.login(loginRequest.email,loginRequest.password,loginRequest.imei,loginRequest.deviceType);

  }

  @override
  Future<ForgotPassEmailResponse> forgotPass(ForgotPassRequest forgotPassRequest) async{
   return await _appServiceClient.forgotPass(forgotPassRequest.email);
  }

  @override
  Future<AuthenticationResponse> register(RegisterRequest registerRequest) async {
  return await _appServiceClient.register(registerRequest.countryMobileCode, registerRequest.username, registerRequest.email, registerRequest.password, registerRequest.mobileNumber, registerRequest.profilePicture);
  }


}