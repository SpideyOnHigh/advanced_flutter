import 'package:advanced_flutter/data/mapper/mapper.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

abstract class FlowState {
  StateRendererTypes getStateRendererTypes();
  String getMessage();
}

//Loading State (POPUP AND FULL SCREEN)
class LoadingState extends FlowState {
  StateRendererTypes stateRendererTypes;
  String message;

  LoadingState({required this.stateRendererTypes, String? message})
      : message = message ?? AppStrings.loading;


  @override
  String getMessage() => message;

  @override
  StateRendererTypes getStateRendererTypes() => stateRendererTypes;
}

class SuccessState extends FlowState{
  StateRendererTypes stateRendererTypes;
  String message;

  SuccessState({required this.stateRendererTypes, String? message})
      : message = message ?? AppStrings.loading;


  @override
  String getMessage() => message;

  @override
  StateRendererTypes getStateRendererTypes() => stateRendererTypes;


}

//Error State (POPUP AND FULL SCREEN)
class ErrorState extends FlowState {
  StateRendererTypes stateRendererTypes;
  String message;

  ErrorState(this.stateRendererTypes, this.message);


  @override
  String getMessage() => message;

  @override
  StateRendererTypes getStateRendererTypes() => stateRendererTypes;
}


//CONTENT STATE
class ContentState extends FlowState {

  ContentState();

  @override
  String getMessage() => EMPTY;

  @override
  StateRendererTypes getStateRendererTypes() => StateRendererTypes.CONTENT_SCREEN_STATE;
}

//EMPTY STATE
class EmptyState extends FlowState {

  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererTypes getStateRendererTypes() => StateRendererTypes.EMPTY_SCREEN_STATE;

}

//it will be called from the view
extension FlowStateExtension on FlowState{
  Widget getScreenWidget(BuildContext context,
      Widget contentScreenWidget,
      Function retryActionFunction){

    switch(this.runtimeType){
      case LoadingState:{
        //we have to check for both popup and full screen state
        if(getStateRendererTypes() == StateRendererTypes.POPUP_LOADING_STATE){

          //showing popup dialog
          //showing above content
          showPopUp(context, getStateRendererTypes(), getMessage());

          //returning the content of ui
          return contentScreenWidget;

        }else{  // StateRendererTypes.FULL_SCREEN_LOADING_STATE
          //showing directly on full screen
          return StateRenderer(stateRendererTypes: getStateRendererTypes(),
              message: getMessage(),
              retryActionFunction: retryActionFunction);
        }
      }
      case SuccessState:{

        //closing any open dialog
        dismissDialog(context);
        //showing popup dialog
        showPopUp(context, getStateRendererTypes(), getMessage());

        //returning the content of ui
        return contentScreenWidget;

      }
      case ErrorState:{
        //if we got error after loading
        //we have to close the loading popup
        dismissDialog(context);

        if(getStateRendererTypes() == StateRendererTypes.POPUP_ERROR_STATE){

          //showing popup dialog
          showPopUp(context, getStateRendererTypes(), getMessage());

          //returning the content of ui
          return contentScreenWidget;

        }else{  //StateRendererTypes.FULL_SCREEN_ERROR_STATE
          return StateRenderer(stateRendererTypes: getStateRendererTypes(),
              message: getMessage(),
              retryActionFunction: retryActionFunction);
        }      }
      case EmptyState:{
        return StateRenderer(stateRendererTypes: getStateRendererTypes(),
            message: getMessage(),
            retryActionFunction: retryActionFunction);
      }
      case ContentState:{

        //Closing the popup dialog before showing any content
        dismissDialog(context);
        return contentScreenWidget;
      }
      default:{
        return contentScreenWidget;
      }
    }
  }

  //dismiss the open dialog
  dismissDialog(BuildContext context){
    //checking if any dialog open
    //if any open we will close them
    if(isThereCurrentDialogShowing(context)){
      Navigator.of(context,rootNavigator: true).pop(true);
    }
  }

  //checking for popup state where there is loading dialog is open and we got the error so,
  //handling multiple popups
  isThereCurrentDialogShowing(BuildContext context) => ModalRoute.of(context)?.isCurrent != true;

  showPopUp(BuildContext context,StateRendererTypes stateRendererTypes,String message){
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
            stateRendererTypes: stateRendererTypes,
            message: message,
            retryActionFunction: (){})));
  }

}

