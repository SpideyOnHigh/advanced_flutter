import 'dart:async';

import 'package:advanced_flutter/domain/usecase/forgot_pass_usecase.dart';
import 'package:advanced_flutter/presentation/base/baseviewmodel.dart';
import 'package:advanced_flutter/presentation/common/freezed_data_classes.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:email_validator/email_validator.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInputs, ForgotPasswordViewModelOutputs {
  //Stream controller for email
  StreamController _emailStreamController =
      StreamController<String>.broadcast();

  //forgotpass freezed object(data class)
  var forgotPassObj = ForgotPassObject("");

  //usecase for calling api
  ForgotPassUseCase _forgotPassUseCase;
  ForgotPasswordViewModel(this._forgotPassUseCase);

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _emailStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Stream<bool> get outputIsEmailValid => _emailStreamController.stream.map((email) => _isEmailValid(email));

  @override
  setEmail(String email) {
    inputEmail.add(email);
    //object will be called whenever we are updating value
    forgotPassObj = forgotPassObj.copyWith(email: email);
  }

  //private functions
  bool _isEmailValid(String email){
    return EmailValidator.validate(email);
  }

  @override
  forgotPass() async {
    inputState.add(LoadingState(stateRendererTypes: StateRendererTypes.POPUP_LOADING_STATE));
    (await _forgotPassUseCase.execute(ForgotPassUseCaseInput(forgotPassObj.email))).fold(
            (failure) => {
              //left -> failure
              //for failure we have to show error state
              inputState.add(ErrorState(StateRendererTypes.POPUP_ERROR_STATE, failure.message))
            },
            (data) => {
              //right ->> success

              inputState.add(SuccessState(stateRendererTypes: StateRendererTypes.POPUP_SUCCESS_STATE,message: data.support))

            });
  }
}

abstract class ForgotPasswordViewModelInputs {
  //actions from view

  setEmail(String email);

  Sink get inputEmail;

  //whenever user enter valid email the email link button will be enabled and when user click on button we should
  //call the forgot pass api (async call)
  forgotPass();
}

abstract class ForgotPasswordViewModelOutputs {
  //we have added sink for email
  //we have to validate email in output stream

  Stream<bool> get outputIsEmailValid;
}
