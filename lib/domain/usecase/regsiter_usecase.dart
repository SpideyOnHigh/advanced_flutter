import 'package:advanced_flutter/app/functions.dart';
import 'package:advanced_flutter/data/network/failure.dart';
import 'package:advanced_flutter/data/request/request.dart';
import 'package:advanced_flutter/domain/model/model.dart';
import 'package:advanced_flutter/domain/repository/repository.dart';
import 'package:advanced_flutter/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase implements BaseUseCase<RegisterUseCaseInput,Authentication>{
  Repository _repository;

  //constructor
  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(input) async{
    
  return await _repository.register(RegisterRequest(input.countryMobileCode, input.username, input.email, input.password, input.mobileNumber, input.profilePicture));

  }

}

//data that is input passed from viewmodels
class RegisterUseCaseInput{
  String countryMobileCode;
  String username;
  String email;
  String password;
  String mobileNumber;
  String profilePicture;
  RegisterUseCaseInput(this.countryMobileCode,this.username,this.email,this.password,this.mobileNumber,this.profilePicture);
}