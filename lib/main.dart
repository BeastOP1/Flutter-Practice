import 'package:flutter/material.dart';
import 'package:flutter_learn/assignment/starter_screen.dart';
import 'package:flutter_learn/books/BookApp.dart';
import 'package:flutter_learn/recipe/AppMainScreen.dart';
import 'package:flutter_learn/start.dart';

import 'assignment2/main.dart';

void main() {
   // runApp(  Start());
  // runApp(  Assignment2Start());
  // runApp(  MyAppStart());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Home Page",
      home: Scaffold(
        appBar:
        AppBar(
          title:  Center(child: Text("My App bar Title"),) ,
          actions: [

          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child:    Text("Hello World"),

            )
          ,
            
            Padding(
              child:  ElevatedButton(
                  onPressed: (){},
                  child: Text("My Button")),
              padding: EdgeInsets.all(10),

            )
           ,
            
            Container(
              color:Colors.redAccent,
              width: 100,
              height: 100,
              child: Text("my Container")
            ),

            Row(
              verticalDirection: VerticalDirection.up,
              spacing: 10,
              children: [
                ElevatedButton(onPressed: (){}, child: Text("Minus")),

                Text("1",textAlign: TextAlign.center,style: TextStyle(
                  fontSize: 22
                ),),
                ElevatedButton(onPressed: (){}, child: Text("Add"),)
              ],
            )
            ,
            Image.asset(
              'assets/dummy.jpg'
            ),
          ],

        ),
      ),

    );
  }

}