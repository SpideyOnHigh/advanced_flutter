import 'package:advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(MaterialApp(home: TestPage()));

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  //to control the page like you can use button to navigate pages
  PageController pageController = PageController(initialPage: 0);
  int pageChanged = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PageView Demo"),
        centerTitle: true,

        actions: [
          IconButton(icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
          },),
          IconButton(icon: Icon(Icons.arrow_forward_ios),
          onPressed: (){
            pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.easeIn);
          },),
        ],
      ),
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            pageChanged = index;
            print(pageChanged);
          });
        },
        controller: pageController,
        physics: ClampingScrollPhysics(),
        children: [
     
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              child: SizedBox(
                height: 20,
                width: 20,
                child: SvgPicture.asset(ImageAssets.leftArrowIc),
              ),
            ),
          ),
          Container(color: Colors.indigo),
          Container(color: Colors.cyan),
        ],
      ),
    );
  }
}
