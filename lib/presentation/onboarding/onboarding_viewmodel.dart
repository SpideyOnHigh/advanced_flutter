import 'dart:async';

import 'package:advanced_flutter/presentation/base/baseviewmodel.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';

import '../../domain/model.dart';
import '../resources/assets_manager.dart';

class OnBoardingViewModel extends BaseViewModel with OnBoardingViewModelInputs,OnBoardingViewModelOutputs{

  //stream controller
  final StreamController _streamController = StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int currentIndex = 0;


  //inputs
  @override
  void dispose() {
    _streamController.close();

  }

  @override
  void start() {
    _list = _getSliderData();

    //send this slider data to our view
    _postDataToView();
  }

  @override
  int goNext() {
    int previousIndex = ++currentIndex;
    if(previousIndex >= _list.length){
      currentIndex = 0; //infinite loop
    }
    return currentIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = --currentIndex;
    if(previousIndex == -1){
      currentIndex = _list.length - 1; //infinite loop
    }
    return currentIndex;
   }

  @override
  void onPageChanged(int index) {
    currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;


  //outputs
  @override
  Stream<SliderViewObject> get outputSliderViewObject => _streamController.stream.map((sliderViewObject) => sliderViewObject);

  //private functions
  List<SliderObject> _getSliderData(){
    return [
      SliderObject(AppStrings.onBoardingTitle1, AppStrings.onBoardingSubTitle1, ImageAssets.onBoardingLogo1),
      SliderObject(AppStrings.onBoardingTitle2, AppStrings.onBoardingSubTitle2, ImageAssets.onBoardingLogo2),
      SliderObject(AppStrings.onBoardingTitle3, AppStrings.onBoardingSubTitle3, ImageAssets.onBoardingLogo3),
      SliderObject(AppStrings.onBoardingTitle4, AppStrings.onBoardingSubTitle4, ImageAssets.onBoardingLogo4),
    ];
  }
  _postDataToView() {
    inputSliderViewObject.add(SliderViewObject(_list[currentIndex], _list.length, currentIndex));

}




}

//input means orders that our viewmodel recieves from our view
abstract class OnBoardingViewModelInputs{

  void goNext(); //when user clicks on right arrow or swipe right
  void goPrevious(); //when user clicks on left arrow or swipe left
  void onPageChanged(int index);

  Sink get inputSliderViewObject; //this is a way to add data to stream... stream input

}
//output means result or data that will be sent from our viewmodel to our view
abstract class OnBoardingViewModelOutputs{

  Stream<SliderViewObject> get  outputSliderViewObject;
}

//this is the class which contains all the data that we should send from viewmodel to view
class SliderViewObject{

  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject,this.numOfSlides,this.currentIndex);

}