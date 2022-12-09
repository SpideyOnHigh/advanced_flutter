import 'dart:async';

import 'package:advanced_flutter/presentation/base/baseviewmodel.dart';

class RegisterViewModel extends BaseViewModel {
  //Stream controllers for all input /validation
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  StreamController _emailStreamController =
      StreamController<String>.broadcast();
  StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  StreamController _mobileNumberStreamController =
      StreamController<String>.broadcast();
  StreamController _profilePictureStreamController =
      StreamController<String>.broadcast();
  StreamController _isAllInputValidStreamController =
  StreamController<String>.broadcast();
  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    _userNameStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _mobileNumberStreamController.close();
    _profilePictureStreamController.close();
    _isAllInputValidStreamController.close();
    _isAllInputValidStreamController.stream.map;

    // TODO: implement dispose
    super.dispose();
  }
}
