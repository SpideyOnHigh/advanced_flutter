import 'package:advanced_flutter/app/functions.dart';
import 'package:advanced_flutter/data/network/failure.dart';
import 'package:advanced_flutter/data/request/request.dart';
import 'package:advanced_flutter/domain/model/model.dart';
import 'package:advanced_flutter/domain/repository/repository.dart';
import 'package:advanced_flutter/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class ForgotPassUseCase implements BaseUseCase<ForgotPassUseCaseInput,ForgotPassWordEmail>{
  Repository _repository;

  //constructor
  ForgotPassUseCase(this._repository);

  @override
  Future<Either<Failure, ForgotPassWordEmail>> execute(input) async{
    return await _repository.forgotPass(ForgotPassRequest(input.email));

  }

}

//data that is input passed from viewmodels
class ForgotPassUseCaseInput{
  String email;

  ForgotPassUseCaseInput(this.email);
}