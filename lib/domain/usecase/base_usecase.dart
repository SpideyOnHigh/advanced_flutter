import 'package:advanced_flutter/data/network/failure.dart';
import 'package:dartz/dartz.dart';

//any usecase have to extend this baseusecase
//it's a generic type where input can be eg, any API Call and output is the object

abstract class BaseUseCase<In,Out>{
  Future<Either<Failure,Out>> execute(In input);
}

