import 'package:flutter/material.dart';

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
          Container(color: Colors.lightBlue),
          Container(color: Colors.indigo),
          Container(color: Colors.cyan),
        ],
      ),
    );
  }
}
