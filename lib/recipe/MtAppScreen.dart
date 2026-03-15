import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/recipe/components/banner_to_explore.dart';
import 'package:flutter_learn/recipe/components/my_icon_widget.dart';
import 'package:flutter_learn/recipe/service/recipe_service.dart';

class MyAppScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppScreenState();
  }
}

class _MyAppScreenState extends State<MyAppScreen> {
  late RecipeService _recipeService;
  final List<String> categories = ["All", "Breakfast", "Lunch", "Dinner"];
  String category = "All";
  late final Stream<List<String>> categoriesStream = Stream.value(categories);

  @override
  void initState() {
    _recipeService = RecipeService();
    _recipeService.loadRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  headerPart(),
                  mySearchBar(),
                  //For Banner
                  const BannerToExplore(),
                  //For Categories
                  const Padding(
                    padding: EdgeInsetsGeometry.symmetric(vertical: 20),
                    child: Text(
                      "Categories",
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  StreamBuilder(
                    stream: categoriesStream,
                    builder: (context, AsyncSnapshot<List<String>> snapshot) {
                      final categoryList = snapshot.data!;
                      if (snapshot.hasData) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              snapshot.data!.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    category = categoryList[index];
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: category == categoryList[index]
                                        ? Colors.teal
                                        : Colors.teal.shade100,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  margin: EdgeInsets.only(right: 20),
                                  child: Text(
                                    categoryList[index],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                  //For Categories
                  const Padding(
                    padding: EdgeInsetsGeometry.symmetric(vertical: 20),
                    child:
                    Text(
                      "Quick & Easy",
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row headerPart() {
    return Row(
      children: [
        const Text(
          "What are you\ncooking today?",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        const Spacer(),
        MyIconWidget(icon: Icons.notifications_none_outlined, pressed: () {}),
      ],
    );
  }

  Padding mySearchBar() {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 16),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          prefixIcon: const Icon(
            Icons.search_rounded,
            size: 35,
            color: Colors.teal,
          ),
          fillColor: Colors.teal.shade50,
          border: InputBorder.none,
          hintText: "Search any recipes",
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
