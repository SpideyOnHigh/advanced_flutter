import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced_flutter/presentation/forgot_password/forgot_password_viewmodel.dart';
import 'package:advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:advanced_flutter/presentation/resources/color_manager.dart';
import 'package:advanced_flutter/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';

import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';
class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {

  final formKey = GlobalKey();

  //controller to check if user has entered something or not
  TextEditingController emailController = TextEditingController();

  final ForgotPasswordViewModel _forgotPasswordViewModel = instance<ForgotPasswordViewModel>();

  _bind(){
    _forgotPasswordViewModel.start();
    emailController.addListener(() =>
        _forgotPasswordViewModel.setEmail(emailController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
        stream: _forgotPasswordViewModel.outputState,
        builder: (context,snapshot){
          return snapshot.data?.getScreenWidget(context, _getContentWidget(), (){}) ??
          _getContentWidget();
        }
    );
  }

  Widget _getContentWidget(){
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: AppPadding.p28,right: AppPadding.p28,top: AppPadding.p100),
              child: Column(
                children: [
                  Image.asset(ImageAssets.splashLogo),
                  const SizedBox(height: AppSize.s28,),
                  StreamBuilder<bool>(
                      stream: _forgotPasswordViewModel.outputIsEmailValid,
                      builder: (context,snapShot) {
                        return TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: AppStrings.enter_email,
                              errorText: (snapShot.data ?? true) ? null : AppStrings.emailError
                          ),
                        );
                      }
                  ),
                  const SizedBox(height: AppSize.s28,),
                  StreamBuilder(
                      stream: _forgotPasswordViewModel.outputIsEmailValid,
                      builder: (context,snapshot) {
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: (snapshot.data ?? true) ? (){
                            _forgotPasswordViewModel.forgotPass();
                          }:  null,
                              child: const Text(AppStrings.reset_pass)
                          ),
                        );
                      }
                  ),
                  const SizedBox(height: AppSize.s8,),
                  Text(AppStrings.didnt_received_email,
                    style: getRegularStyle(color: ColorManager.primary),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _forgotPasswordViewModel.dispose();
    super.dispose();
  }
}
