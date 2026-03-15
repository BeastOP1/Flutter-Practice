import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopularBookCard extends StatelessWidget {
  final String text;
  const PopularBookCard ({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            Colors.yellow,
            Colors.deepOrangeAccent,
          ],
          begin: AlignmentGeometry.directional(0, 4),
          end: AlignmentGeometry.directional(-2, 0),
          tileMode: TileMode.clamp,
        ),
        shape: BoxShape.rectangle,
        border: BoxBorder.all(
          color: Colors.white38,
          width: 2,
        ),
        // image: DecorationImage(
        //   image: AssetImage("assets/dummy.jpg"),
        //   fit: BoxFit.fitWidth,
        // ),
      ),
      alignment: AlignmentGeometry.center,
      child: Text(
        style: TextStyle(
          fontSize: 40,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        this.text,
        textAlign: TextAlign.center,
      ),
    );
  }
}



class BookCard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.lightBlueAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/dummy.jpg",height: 100,semanticLabel: "Hello",),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Content"),
              Icon(Icons.ice_skating),
              TextButton(onPressed: ()=>{}, child: Text("My Button"))
            ],
          )
        ],
      ),
    );
  }
}