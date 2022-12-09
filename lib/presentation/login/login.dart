import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced_flutter/presentation/login/login_viewmodel.dart';
import 'package:advanced_flutter/presentation/resources/color_manager.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:advanced_flutter/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../app/di.dart';
import '../resources/assets_manager.dart';
import '../resources/routes_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //TODO:TO REMOVE THIS KIND OF DEPENDENCY WE USE DEPENDENCY INJECTION
  // SharedPreferences _sharedPreferences =  SharedPreferences.getInstance();
  // AppPreferences _appPreferences = AppPreferences(_sharedPreferences);
  // DioFactory dio = DioFactory(_appPreferences);
  // AppServiceClient _appServiceClient = AppServiceClient(dio.getDio())
  // RemoteDataSource _remoteDataSource = RemoteDataSourceImplementer(_appServiceClient)
  // Repository _repository = RepositoryImpl(_remoteDataSource, _networkInfo);
  // LoginUseCase _loginUseCase = LoginUseCase(_repository);

  //getting instance of viewModel directly from GetIt
  //it will magically get it all the required insatances
  //here we needed UseCase Insatnce
  final LoginViewModel _loginViewModel = instance<LoginViewModel>();

  //controller to check if user has entered something or not
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //to show the eye button by returning bool value(state depend)
  bool _isObscure = true;

  final formKey = GlobalKey<FormState>();

  _bind() {
    _loginViewModel.start();
    userNameController.addListener(
        () => _loginViewModel.setUserName(userNameController.text));
    passwordController.addListener(
        () => _loginViewModel.setPassword(passwordController.text));
    _loginViewModel.outputIsUserLoggedIn.listen((isUserLoggedIn) {
      //it's a listing subscriber method so we need to have this
      //scheduler binding
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, Routes.mainRoute);
      });
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
      //getting stream data from viewmodel
      stream: _loginViewModel.outputState,
      builder: (context, snapshot) {
        return snapshot.data?.getScreenWidget(context, _getContentWidget(), () {
              _loginViewModel.login();
            }) ??
            _getContentWidget();
      },
    );
  }

  Widget _getContentWidget() {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: AppPadding.p100),
        color: ColorManager.white,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Image.asset(ImageAssets.splashLogo),
                const SizedBox(height: AppSize.s28),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _loginViewModel.outputIsUserNameValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: userNameController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: AppStrings.username,
                            labelText: AppStrings.username,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.usernameError),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSize.s28),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _loginViewModel.outputIsPasswordValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(

                                onPressed: (){
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                                icon: Icon(
                                  _isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                )),
                            hintText: AppStrings.password,
                            labelText: AppStrings.password,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.passwordError),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSize.s28),
                Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p28, right: AppPadding.p28),
                    child: StreamBuilder<bool>(
                      stream: _loginViewModel.outputsIsAllInputsValid,
                      builder: (context, snapshot) {
                        return SizedBox(
                          width: double.infinity,
                          height: AppSize.s40,
                          child: ElevatedButton(
                              onPressed: (snapshot.data ?? false)
                                  ? () {
                                      _loginViewModel.login();
                                    }
                                  : null,
                              child: Text(AppStrings.login)),
                        );
                      },
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      top: AppPadding.p8,
                      left: AppPadding.p28,
                      right: AppPadding.p28),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.forgotPasswordRoute);
                          },
                          child: Text(
                            AppStrings.forgetPassword,
                            style: TextStyle(color: ColorManager.primary),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.registerRoute);
                          },
                          child: Text(
                            AppStrings.register,
                            style: TextStyle(color: ColorManager.primary),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginViewModel.dispose();
    super.dispose();
  }

  _validate(bool a) {
    if (a == true) {
      _loginViewModel.login();
    }
    return null;
  }
}
