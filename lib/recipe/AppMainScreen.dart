import 'package:flutter/material.dart';
import 'package:flutter_learn/recipe/MtAppScreen.dart';

class MyAppStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppMainScreen(),
    );
  }
}

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int selectedIndex = 0;
  late final List<Widget> page;

  @override
  void initState() {
    page = [
      MyAppScreen(),
      navBarPage(Icons.highlight),
      navBarPage(Icons.celebration),
      navBarPage(Icons.ice_skating_rounded),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        iconSize: 30,
        selectedLabelStyle: TextStyle(color: Colors.white, fontSize: 16),
        showSelectedLabels: false,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade100,

        items: [
          BottomNavigationBarItem(
            icon: Icon(selectedIndex == 0 ? Icons.home : Icons.home_outlined),
            label: "Home",
            backgroundColor: Colors.teal,
            tooltip: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 0 ? Icons.favorite_outline : Icons.favorite,
            ),
            label: "Favorite",
            backgroundColor: Colors.teal,
            tooltip: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 0 ? Icons.set_meal_outlined : Icons.set_meal,
            ),
            label: "Meal Plan",
            backgroundColor: Colors.teal,
            tooltip: "Meal Plan",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 0 ? Icons.settings : Icons.settings_outlined,
            ),
            label: "Setting",
            backgroundColor: Colors.teal,
            tooltip: "Setting",
          ),
        ],
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
      ),
      body: page[selectedIndex],
    );
  }

  navBarPage(iconName) {
    return Center(child: Icon(iconName, size: 100, color: Colors.orangeAccent));
  }
}
