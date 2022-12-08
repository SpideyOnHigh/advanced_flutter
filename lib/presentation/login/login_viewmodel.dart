import 'dart:async';
import 'dart:math';

import 'package:advanced_flutter/app/app_prefs.dart';
import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/domain/usecase/login_usecase.dart';
import 'package:advanced_flutter/presentation/base/baseviewmodel.dart';
import 'package:advanced_flutter/presentation/common/freezed_data_classes.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  //Adding Stream Controller
  //broadcast means many subscribers can listen to one stream
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  StreamController _isALlInputValidStreamController =
      StreamController<void>.broadcast();
  StreamController _isUserLoggedInSuccessFullyStreamController =
      StreamController<bool>();

  AppPreferences _appPreferences = instance<AppPreferences>();

  //loginObject data class
  var loginObject = LoginObject("", "");

  //login usecase for calling api
  LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

  //inputs
  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _isALlInputValidStreamController.close();
    _isUserLoggedInSuccessFullyStreamController.close();
  }

  @override
  void start() {
    //viewModel tells the view to load the content state
    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputIsAllInputsValid => _isALlInputValidStreamController.sink;

  @override
  Sink get inputisUserLoggedIn =>
      _isUserLoggedInSuccessFullyStreamController.sink;

  @override
  login() async {
    //on click of login we have to show loading state
    inputState.add(LoadingState(
        stateRendererTypes: StateRendererTypes.POPUP_LOADING_STATE));
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.userName, loginObject.password)))
        .fold(
            (failure) => {
                  //left -> failure
                  //for failure we have to show error state
                  inputState.add(ErrorState(
                      StateRendererTypes.POPUP_ERROR_STATE, failure.message))
                }, (data) {
      //right ->> success
      inputState.add(ContentState());

      //Navigate to main screen after login
      //we got success so user logged in so adding true to our loggedin checking stream
      inputisUserLoggedIn.add(true);

      //adding user logged in to shared pref so next time we
      //don't have to see the login screen
      //todo uncomment in final build
      // _appPreferences.setUserLoggedIn();
    });
  }

  //adding password to sink(inputing through sink)
  @override
  setPassword(String password) {
    inputPassword.add(password);
    //object will be called whenever we are updating value
    loginObject =
        loginObject.copyWith(password: password); //data class operation
    _isALlInputValidStreamController.add(null);
  }

  //adding username to sink(inputing through sink)
  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    //object will be called whenever we are updating value
    loginObject =
        loginObject.copyWith(userName: userName); //data class operation
    _isALlInputValidStreamController.add(null);
  }

  //outputs
  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get outputsIsAllInputsValid =>
      _isALlInputValidStreamController.stream.map((_) => _isAllInputsValid());

  @override
  Stream get outputIsUserLoggedIn =>
      _isUserLoggedInSuccessFullyStreamController.stream;

  //private functions
  //validating username and password because we have to return in bool

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  bool _isAllInputsValid() {
    return _isUserNameValid(loginObject.userName) &&
        _isPasswordValid(loginObject.password);
  }
}

//input means actions fromm view
abstract class LoginViewModelInputs {
  //three functions for actions
  //when user enter the username in view we have to send that username to viewmodel

  setUserName(String userName);

  setPassword(String password);

  //whenever user enter valid username and password the login button will be enabled and when user click on login button we should
  //call the login api (async call)
  login();

  //2 sinks for streams (it's for validating username and password)
  //sink is basically inputs for stream

  Sink get inputUserName;

  Sink get inputPassword;

  //to disable or enable login button if username and password is valid its enable otherwise disabled
  //we are not passing any input
  Sink get inputIsAllInputsValid;

  //to navigate to main screen after logging in successfully
  Sink get inputisUserLoggedIn;
}

abstract class LoginViewModelOutputs {
  //as we have added two sink we also need two streams for output
  //once user enters in sink we have to validate it and return true or false
  Stream<bool> get outputIsUserNameValid;

  Stream<bool> get outputIsPasswordValid;

  //to disable or enable login button if username and password is valid its enable otherwise disabled
  //outputs true or false
  Stream<bool> get outputsIsAllInputsValid;

  //
  Stream get outputIsUserLoggedIn;
}

//NOTE: TO UPDATE THE USERNAME AND PASSWORD WE NEED FREEZED BECOZ WE DONT HAVE DATA CLASSES IN DART. USER CAN CHANGE
//AFTER WRITING ONCE
