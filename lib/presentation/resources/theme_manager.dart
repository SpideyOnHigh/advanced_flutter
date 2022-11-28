import 'package:advanced_flutter/presentation/resources/color_manager.dart';
import 'package:advanced_flutter/presentation/resources/font_manager.dart';
import 'package:advanced_flutter/presentation/resources/styles_manager.dart';
import 'package:advanced_flutter/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme(){
  return ThemeData(

    //main colors of the app
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryOpacity70,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1, //will be used when button is disabled for ex
    accentColor: ColorManager.grey,
    //ripple color -- it's the color which is shown when we tap on somethin'
    splashColor: ColorManager.primaryOpacity70,

    //Card View Theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),



   //AppBar Theme
   appBarTheme: AppBarTheme(
      color: ColorManager.primary,
      centerTitle: true,
      shadowColor: ColorManager.primaryOpacity70,
      elevation: AppSize.s4,
      titleTextStyle: getRegularStyle(color: ColorManager.white,fontSize: AppSize.s16 )
   ),

    //Button Theme
    buttonTheme: ButtonThemeData(
      shape: StadiumBorder(),
      buttonColor: ColorManager.primary,
      disabledColor: ColorManager.grey1,
      splashColor: ColorManager.primaryOpacity70,
     ),

    //Eleveated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(color: ColorManager.white),
        primary: ColorManager.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s12))
      )
    ),

    //Text Style Theme
    textTheme: TextTheme(
      headline1: getSemiBoldStyle(color: ColorManager.darkGrey,fontSize: FontSize.s16),
      subtitle1: getMediumStyle(color: ColorManager.lightGrey,fontSize: FontSize.s14),
      caption: getRegularStyle(color: ColorManager.grey1),
      bodyText1: getRegularStyle(color: ColorManager.grey),
    ),

    //input decoration theme (Text Form Field)
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(AppPadding.p8),

      //hint style
      hintStyle: getRegularStyle(color: ColorManager.grey1),

      //label style
      labelStyle: getRegularStyle(color: ColorManager.darkGrey),

      //error style
      errorStyle: getRegularStyle(color: ColorManager.error),

      //enabled border(which normally looks)
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.grey,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))
      ),

      //focused border(when someone clicks and there ain't any error)
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.primary,
            width: AppSize.s1_5,
          ),
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))
      ),

      //error border(when there's error)
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.error,
            width: AppSize.s1_5,
          ),
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))
      ),

      //focused error border(when there is a error in field and you tap on that field)
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.primary,
            width: AppSize.s1_5,
          ),
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))
      ),
    )
  );
}