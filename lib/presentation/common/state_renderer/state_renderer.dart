import 'package:advanced_flutter/data/mapper/mapper.dart';
import 'package:advanced_flutter/data/network/failure.dart';
import 'package:advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:advanced_flutter/presentation/resources/color_manager.dart';
import 'package:advanced_flutter/presentation/resources/font_manager.dart';
import 'package:advanced_flutter/presentation/resources/styles_manager.dart';
import 'package:advanced_flutter/presentation/resources/values_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../resources/strings_manager.dart';

enum StateRendererTypes {
  //POPUP STATE
  POPUP_LOADING_STATE, //LOADING IN POPUP
  POPUP_ERROR_STATE, //ERROR IN POPUP
  POPUP_SUCCESS_STATE, //SUCESS STAE IN POPUP

  //FULL SCREEN STATE
  FULL_SCREEN_LOADING_STATE, //LOADING IN FULL SCREEN
  FULL_SCREEN_ERROR_STATE, //ERROR IN FULL SCREEN
  CONTENT_SCREEN_STATE, //ACTUAL UI OF THE SCREENS
  EMPTY_SCREEN_STATE, //USED WHEN WE DON'T HAVE ANY DATA TO SHOW, FOR EX, NO DATA RECEIVED FROM API

}

class StateRenderer extends StatelessWidget {
  //Params needed in this widget
  StateRendererTypes
      stateRendererTypes; //which state to show for that we needed this
  String message; //message for simple as well as error
  String title; //todo will update later
  Function
      retryActionFunction; // if any error received we can use this button for retrying

  //constructor
  StateRenderer(
      {Key? key,
      required this.stateRendererTypes,
      String? message, //todo don't know why
      String? title,
      required this.retryActionFunction})
      : message = message ?? AppStrings.loading,
        title = title ?? EMPTY,
        super(key: key);


  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context){
    switch(stateRendererTypes){

      //POPUP STATES
      case StateRendererTypes.POPUP_LOADING_STATE:
        return getPopUpDialog(context,[_getAnimatedImage(JsonAssets.loading)]);
      case StateRendererTypes.POPUP_SUCCESS_STATE:
        return getPopUpDialog(context,[_getAnimatedImage(JsonAssets.email),_getMessage(message),_getRetryButton(AppStrings.ok, context)]);
      case StateRendererTypes.POPUP_ERROR_STATE:
        return getPopUpDialog(context,[_getAnimatedImage(JsonAssets.error),_getMessage(message),_getRetryButton(AppStrings.ok,context)]);

      //FULL SCREEN STATES
      case StateRendererTypes.FULL_SCREEN_LOADING_STATE:
        return getItemsInColumn([_getAnimatedImage(JsonAssets.loading),_getMessage(message)]);

      case StateRendererTypes.FULL_SCREEN_ERROR_STATE:
        return getItemsInColumn([_getAnimatedImage(JsonAssets.error),_getMessage(message),_getRetryButton(AppStrings.retry_again,context)],);

      case StateRendererTypes.CONTENT_SCREEN_STATE:
        return Container();
      case StateRendererTypes.EMPTY_SCREEN_STATE:
        return getItemsInColumn([_getAnimatedImage(JsonAssets.empty),_getMessage(message)]);


      default:
        return Container();
    }
  }


  Widget getPopUpDialog(BuildContext context,List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s14)),
      backgroundColor: Colors.transparent,
      elevation: AppSize.s1_5,
      child: Container(
        decoration: BoxDecoration(
            color: ColorManager.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSize.s14),
            boxShadow: [BoxShadow(color: Colors.black26,blurRadius: AppSize.s12,offset: Offset(AppSize.s0, AppSize.s12))]
        ),
        child: _getDialogContent(context,children),
      ),

    );
  }

  Widget _getDialogContent(BuildContext context,List<Widget> children){
    return Column(
      //giving this property to change popup dialog height dynamically according to content
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }


  Widget _getMessage(String message){
    return Center(child: Text(message,style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s16),));
  }


  //we have to handle two actions
  //for full screen retry call
  //for pop state to dismiss dialog
  Widget _getRetryButton(String buttonTitle,BuildContext context){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(

          width: AppSize.s180,
          child: ElevatedButton(onPressed: (){
            if(stateRendererTypes == StateRendererTypes.FULL_SCREEN_ERROR_STATE){
              retryActionFunction.call();
            }else{
              Navigator.of(context).pop();
            }
          },
              child: Text(buttonTitle)),
        ),
      ),
    );
  }

  Widget _getAnimatedImage(String animationName){
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,

      child: Lottie.asset(animationName), //Json image
    );
  }

  Widget getItemsInColumn(List<Widget> children){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }

}
