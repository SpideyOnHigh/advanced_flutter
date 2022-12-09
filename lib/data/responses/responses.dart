import 'dart:html';
import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

//first step : add response
// run "flutter clean" first and add line "part 'responses.g.dart' "
// before run "flutter pub run build_runner build --delete-conflicting-outputs" ..after creating constructor


@JsonSerializable()
class BaseResponse{
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class CustomerResponse{
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numOfNotifications")
  int? numOfNotifications;

  //constructor
  CustomerResponse(this.id,this.name,this.numOfNotifications);

  //from JSON
  factory CustomerResponse.fromJson(Map<String,dynamic> json) => _$CustomerResponseFromJson(json);

  //toJson
  Map<String,dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse{
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "link")
  String? link;
  @JsonKey(name: "email")
  String? email;

  //constructor
  ContactsResponse(this.email,this.phone,this.link);

  //from JSON
  factory ContactsResponse.fromJson(Map<String,dynamic> json) => _$ContactsResponseFromJson(json);

  //toJson
  Map<String,dynamic> toJson() => _$ContactsResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse{
  @JsonKey(name:"customer")
  CustomerResponse customer;
  @JsonKey(name:"contacts")
  ContactsResponse contacts;

  AuthenticationResponse(this.contacts,this.customer);

  //run command to autogenerate returns
  //from JSON
  factory AuthenticationResponse.fromJson(Map<String,dynamic> json) => _$AuthenticationResponseFromJson(json);

  //toJson
  Map<String,dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

//response that we get from ForgotPass api
@JsonSerializable()
class ForgotPassEmailResponse extends BaseResponse{

  @JsonKey(name: "support")
  String? support;
  ForgotPassEmailResponse(this.support);

  //from JSON
  factory ForgotPassEmailResponse.fromJson(Map<String,dynamic> json) => _$ForgotPassEmailResponseFromJson(json);

  //toJson
  Map<String,dynamic> toJson() => _$ForgotPassEmailResponseToJson(this);


}

