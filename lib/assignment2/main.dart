
import 'package:flutter/material.dart';
import 'component/custom_app_bar.dart';
import 'component/custom_nav_bar.dart';

class Assignment2Start extends StatelessWidget {
  const Assignment2Start({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home(), debugShowCheckedModeBanner: false,);
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  late final List<Widget> page;
  late final List<String> dynamicTitles;
  late final List<Color> dynamicColors;
  @override
  void initState() {
    dynamicTitles =[
      'Discover',
      'Favorite',
      'Mails',
      'Setting'
    ];

    dynamicColors = [
      Colors.pinkAccent,
      Colors.green,
      Colors.brown,
      Colors.deepPurple,

    ];
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      primary: true,
      bottomNavigationBar: CustomNavBar(
        onTabChange: (index) {

          print("Screen Index ${index}");
          setState(() {
            selectedIndex = index;
          });
        },
        inactiveIconColor: Color(0xFF5F6368),
        items: [
          NavBarItem(icon: Icons.search, label: 'Search'),
          NavBarItem(icon: Icons.favorite, label: 'Add to Favorite'),
          NavBarItem(icon: Icons.mail, label: 'Email'),
          NavBarItem(icon: Icons.settings, label: 'Settings'),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsetsDirectional.all(16),
              height: 200,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: dynamicColors[selectedIndex].withGreen(selectedIndex),
                borderRadius: BorderRadiusGeometry.circular(16),
              ),
              child: Icon(
                Icons.insert_emoticon_sharp,
                size: 180,
                color: Colors.white,
              ),
            ),
            Container(
              margin: EdgeInsetsDirectional.all(16),
              height: 200,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: dynamicColors[selectedIndex].withRed(selectedIndex),
                borderRadius: BorderRadiusGeometry.circular(16),
              ),
              child: Icon(
                Icons.insert_emoticon_rounded,
                size: 180,
                color: Colors.white,
              ),
            ),
            Container(
              margin: EdgeInsetsDirectional.all(16),
              height: 400,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: dynamicColors[selectedIndex].withBlue(selectedIndex),
                borderRadius: BorderRadiusGeometry.circular(16),
              ),
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeCap: StrokeCap.round,
                strokeWidth: 8,
                padding: EdgeInsetsDirectional.all(132),
              )
            ),
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 70),
        child: CustomAppBar(
          title: dynamicTitles.length<=0 ? 'Loading': dynamicTitles[selectedIndex],
          subTitle: 'Chicago,||',
          onBackPress: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Back Button Pressed'),
              ),
            );

          },
          onMenuPress: () {

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Menu Button Pressed'),
                duration: Duration(seconds: 2),
                backgroundColor: Color(0xFFDC87CE),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
      ),
    );
  }
}
