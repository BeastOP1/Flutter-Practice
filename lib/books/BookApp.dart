import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/books/components/BookCard.dart';
import 'package:flutter_learn/books/components/MyTabButtons.dart';
import 'package:flutter_learn/recipe/AppMainScreen.dart';
import 'package:flutter_learn/recipe/MtAppScreen.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late List listofNames;
  late ScrollController _scrollController;
  late TabController _tabController;

  ReadData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/dummy.json")
        .then(
          (data) => {
            setState(() {
              listofNames = json.decode(data);
            }),
          },
        );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController(initialScrollOffset: 0);
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Book",
      color: Colors.white,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade50,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16, right: 10),
                child: Row(
                  verticalDirection: VerticalDirection.up,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.menu, size: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.values.first,
                      spacing: 16,
                      children: [
                        Icon(Icons.search, size: 25),
                        Icon(Icons.notifications_active, size: 25),
                      ],
                    ),
                  ],
                ),
              ), //Main TopBar
              Container(
                margin: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  "Popular Books",
                  style: TextStyle(
                    fontSize: 24,
                    textBaseline: TextBaseline.alphabetic,
                  ),
                  textAlign: TextAlign.start,
                ),
              ), //Header
              Container(
                height: 200,
                margin: EdgeInsets.symmetric(vertical: 16),
                child: Stack(
                  children: [
                    Positioned(
                      left: -16,
                      top: 0,
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: double.maxFinite,
                        height: 200,
                        child: PageView.builder(
                          controller: PageController(viewportFraction: 0.8),
                          itemBuilder: (_, i) {
                            return PopularBookCard(
                              text: listofNames[i]["name"],
                            );
                          },
                          itemCount: listofNames.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (BuildContext context, bool isScroll) {
                    return [
                      SliverAppBar(
                        pinned: true,
                        backgroundColor: Colors.white,
                        bottom: PreferredSize(
                          preferredSize: Size.fromHeight(30),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: TabBar(
                              labelColor: Colors.black,
                              tabAlignment: TabAlignment.center,
                              tabs: [
                                MyTabButtons(
                                  text: "Games",
                                  color: Colors.pinkAccent,
                                ),
                                MyTabButtons(
                                  text: "Sports",
                                  color: Colors.yellowAccent,
                                ),
                                MyTabButtons(
                                  text: "Entertainment",
                                  color: Colors.deepOrangeAccent,
                                ),
                              ],
                              dividerColor: Colors.transparent,
                              indicatorPadding: EdgeInsetsGeometry.all(0),
                              indicatorSize: TabBarIndicatorSize.label,
                              labelPadding: EdgeInsetsGeometry.only(right: 10),
                              controller: _tabController,
                              isScrollable: true,
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.greenAccent.shade100,
                                border: BoxBorder.all(
                                  color: Colors.greenAccent,
                                  width: 1,
                                  strokeAlign: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.greenAccent,
                                    blurRadius: 5,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.builder(
                        itemBuilder: (_, i) {
                          return Container(
                            margin: EdgeInsets.only(
                              left: 20,
                              right: 20,
                              bottom: 10,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2,
                                    offset: Offset(0, 0),
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  spacing: 16,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage("assets/dummy.jpg"),
                                          fit: BoxFit.fitHeight,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: 8,
                                      verticalDirection: VerticalDirection.down,
                                      children: [
                                        Row(
                                          spacing: 8,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              size: 22,
                                              color: Colors.yellow,
                                            ),
                                            Text(
                                              "4.5 ",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.orangeAccent,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "THE WATER CURE",
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            color: Colors.lightBlueAccent,
                                          ),
                                          height: 30,
                                          width: 50,
                                          child: Text(
                                            "Live",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: 8,
                      ),
                      
                      BookCard(),
                      Material(
                        child: ListTile(
                          leading: CircleAvatar(backgroundColor: Colors.grey),
                          title: Text("data"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
