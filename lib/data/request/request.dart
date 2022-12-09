//for repository

class LoginRequest{
  String email;
  String password;
  String imei;
  String deviceType;

  LoginRequest(this.email,this.password,this.imei,this.deviceType);
}

class ForgotPassRequest{
  String email;

  ForgotPassRequest(this.email);
}

class RegisterRequest{
  String countryMobileCode;
  String username;
  String email;
  String password;
  String mobileNumber;
  String profilePicture;

  RegisterRequest(this.countryMobileCode,this.username,this.email,this.password,this.mobileNumber,this.profilePicture);
}