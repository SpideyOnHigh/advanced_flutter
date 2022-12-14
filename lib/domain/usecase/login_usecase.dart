import 'package:advanced_flutter/app/functions.dart';
import 'package:advanced_flutter/data/network/failure.dart';
import 'package:advanced_flutter/data/request/request.dart';
import 'package:advanced_flutter/domain/model/model.dart';
import 'package:advanced_flutter/domain/repository/repository.dart';
import 'package:advanced_flutter/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput,Authentication>{
  Repository _repository;

  //constructor
  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(input) async{
  DeviceInfo deviceInfo = await getDeviceDetails();
  return await _repository.login(LoginRequest(input.email, input.password,"",""));

  }

}

//data that is input passed from viewmodels
class LoginUseCaseInput{
  String email;
  String password;

  LoginUseCaseInput(this.email,this.password);
}