import 'package:advanced_flutter/domain/model/model.dart';
import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../../data/request/request.dart';

abstract class Repository {
  //either(coz 2 possible response data or error) response Left or Right here Left is Failure and Right is our resposne
  //we have use Authentication instead of AuthenticationResponse because e have Mapped Data toDomain (Model)

  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);

  Future<Either<Failure, Authentication>> register(RegisterRequest registerRequest);

  Future<Either<Failure,ForgotPassWordEmail>> forgotPass(ForgotPassRequest forgotPassRequest);
}
