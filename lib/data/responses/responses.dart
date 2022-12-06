import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

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