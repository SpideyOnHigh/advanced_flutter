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
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: AppStrings.enter_email,
                    ),
                  ),
                  const SizedBox(height: AppSize.s28,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: (){},
                        child: const Text(AppStrings.reset_pass)
                    ),
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
}
