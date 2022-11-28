import 'package:advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:advanced_flutter/presentation/resources/color_manager.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:advanced_flutter/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {

  late final List<SliderObject> _list = _getSliderData();
  PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

   List<SliderObject> _getSliderData(){
     return [
       SliderObject(AppStrings.onBoardingTitle1, AppStrings.onBoardingSubTitle1, ImageAssets.onBoardingLogo1),
       SliderObject(AppStrings.onBoardingTitle2, AppStrings.onBoardingSubTitle2, ImageAssets.onBoardingLogo2),
       SliderObject(AppStrings.onBoardingTitle3, AppStrings.onBoardingSubTitle3, ImageAssets.onBoardingLogo3),
       SliderObject(AppStrings.onBoardingTitle4, AppStrings.onBoardingSubTitle4, ImageAssets.onBoardingLogo4),
     ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: AppSize.s1_5,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: PageView.builder(

        controller: _pageController,
        itemCount: _list.length,
        onPageChanged: (index){
          setState(() {
            currentIndex = index;
          });
        },

          itemBuilder: (context,index){
          return OnBoardingPage(_list[index]);
          }) ,

      bottomSheet: Container(
        color: ColorManager.white,
        height: AppSize.s100,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    AppStrings.skip,
                    style: TextStyle(color: ColorManager.primary),
                  )),
            ),

            _getBottomSheetWidget(),

          ],
        ),
      ),
    );
  }

 Widget _getBottomSheetWidget() {
     return Row(
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
             onTap: (){},
           ),
         ),

         Row(
           children: [
             for(int i=0;i<_list.length;i++)
               Padding(
                 padding: EdgeInsets.all(AppPadding.p8),
                 child: _getProperCircle(i),
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
             onTap: (){},
           ),
         ),
       ],
     );
 }

 Widget _getProperCircle(int index){
     if(index == currentIndex)
       return SvgPicture.asset(ImageAssets.hollowCircleIc);
     else
       return SvgPicture.asset(ImageAssets.solidCircleIc);
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



class SliderObject{
  String title;
  String subTitle;
  String image;

  SliderObject(this.title,this.subTitle,this.image);
}
