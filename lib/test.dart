import 'package:flutter/material.dart';
import 'app/app.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  //updating no variable with instance created in app file
  void updateNo(){
    MyApp.instance.no = 12;
  }


  //accessing no variable with instance created in app dart file
  void display(){
    print(MyApp.instance.no);
  }

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
