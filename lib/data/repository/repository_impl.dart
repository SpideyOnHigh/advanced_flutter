import 'package:advanced_flutter/data/data_source/remote_data_source.dart';
import 'package:advanced_flutter/data/mapper/mapper.dart';
import 'package:advanced_flutter/data/network/error_handler.dart';
import 'package:advanced_flutter/data/network/failure.dart';
import 'package:advanced_flutter/data/network/network_info.dart';
import 'package:advanced_flutter/data/request/request.dart';
import 'package:advanced_flutter/domain/model/model.dart';
import 'package:advanced_flutter/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl extends Repository{
  RemoteDataSource _remoteDataSource;
  NetworkInfo _networkInfo;

  //constructor
  RepositoryImpl(this._remoteDataSource,this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async{
    //before calling the API we need to check for internet connection
    if(await _networkInfo.isConnected){
      try{
        //its safe to call API
        final response = await _remoteDataSource.login(loginRequest);

        //check if response's code for success and failure
        if(response.status == ApiInternalStatus.SUCCESS){
          //return data
          //return right side data
          //convert it using toDomain (model)
          return Right(response.toDomain());
        }

        //business logic error IT'S APIS INTERNAL STATUS ERROR
        else{
          return Left(Failure(response.status?? ApiInternalStatus.FAILURE,response.message?? ResponseMessage.DEFAULT));
        }

      }
      catch(error){
       return(Left(ErrorHandler.handle(error).failure));
      }

    }
    else{
      //return internet connection error
      return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION, ResponseMessage.NO_INTERNET_CONNECTION));

    }


  }

}