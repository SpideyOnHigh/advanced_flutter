import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';


//auto generate by running magic command
@freezed
class LoginObject with _$LoginObject{
  factory LoginObject(String userName,String password) = _LoginObject;

}

@freezed
class ForgotPassObject with _$ForgotPassObject{
  factory ForgotPassObject(String email) = _ForgotPassObject;
}
