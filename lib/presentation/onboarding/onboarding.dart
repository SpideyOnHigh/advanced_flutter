import 'package:advanced_flutter/app/app_prefs.dart';
import 'package:advanced_flutter/presentation/onboarding/onboarding_viewmodel.dart';
import 'package:advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:advanced_flutter/presentation/resources/color_manager.dart';
import 'package:advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:advanced_flutter/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../app/di.dart';
import '../../domain/model/model.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {

  PageController _pageController = PageController(initialPage: 0);
  OnBoardingViewModel _viewModel = OnBoardingViewModel();
  AppPreferences _appPreferences = instance<AppPreferences>();

  _bind(){
    //todo uncomment in final release
    // _appPreferences.setOnBoardingScreenViewed();
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
        stream: _viewModel.outputSliderViewObject,
        builder: (context,snapShot){
          print(snapShot);
          return  _getContentWidget(snapShot.data);
        }
    );
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject){
    if(sliderViewObject == null){
      return Container();
    }
    else{
   return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: AppSize.s0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: PageView.builder(

          controller: _pageController,
          itemCount: sliderViewObject.numOfSlides,
          onPageChanged: (index){
           _viewModel.onPageChanged(index);
          },

          itemBuilder: (context,index){
            return OnBoardingPage(sliderViewObject.sliderObject);
          }) ,

      bottomSheet: Container(
        color: ColorManager.white,
        height: AppSize.s100,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.loginRoute);
                  },
                  child: Text(
                    AppStrings.skip,
                    style: TextStyle(color: ColorManager.primary),
                  )),
            ),

            _getBottomSheetWidget(sliderViewObject),
          ],
        ),
      ),
    );}
  }

 Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {
     return Container(
       color: ColorManager.primary,
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           //left arrow
           Padding(
             padding: const EdgeInsets.all(AppPadding.p14),
             child: GestureDetector(
               child: SizedBox(
                 height: AppSize.s20,
                 width: AppSize.s20,
                 child: SvgPicture.asset(ImageAssets.leftArrowIc),
               ),
               onTap: (){
                   _pageController.animateToPage(_viewModel.goPrevious(), duration: Duration(milliseconds: DurationConstant.d300), curve: Curves.ease);
               },
             ),
           ),

           Row(
             children: [
               for(int i=0;i< sliderViewObject.numOfSlides;i++)
                 Padding(
                   padding: EdgeInsets.all(AppPadding.p8),
                   child: _getProperCircle(i,_viewModel.currentIndex),
                 )

             ],
           ),


           //right arrow
           Padding(
             padding: const EdgeInsets.all(AppPadding.p14),
             child: GestureDetector(
               child: SizedBox(
                 height: AppSize.s20,
                 width: AppSize.s20,
                 child: SvgPicture.asset(ImageAssets.rightArrowIc),
               ),
               onTap: (){
                 _pageController.animateToPage(_viewModel.goNext(), duration: Duration(milliseconds: DurationConstant.d300), curve: Curves.ease);
               },
             ),
           ),
         ],
       ),
     );
 }

 Widget _getProperCircle(int index, int currentIndex){
     if(index == currentIndex)
       return SvgPicture.asset(ImageAssets.hollowCircleIc);
     else
       return SvgPicture.asset(ImageAssets.solidCircleIc);
 }

  @override
  void dispose(){
    _viewModel.dispose();
    super.dispose();

  }
  }






class OnBoardingPage extends StatelessWidget {
  SliderObject _sliderObject;
  OnBoardingPage(this._sliderObject,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: AppSize.s40,),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(_sliderObject.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(_sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(height: AppSize.s60,),
        SvgPicture.asset(_sliderObject.image),


      ],
    );
  }
}


