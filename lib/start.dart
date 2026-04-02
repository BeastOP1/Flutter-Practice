// import 'package:flutter/material.dart';
// import 'package:flutter_learn/assignment/starter_screen.dart';
//
// import 'assignment2/main.dart';
//
// class Start extends StatelessWidget {
//   const Start({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Momotaro-App",
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         fontFamily: 'Rubik', // optional
//       ),
//       home: HomeScreen(),
//       initialRoute: '/',
//       // The app starts here
//       routes: {
//         '/first': (context) => StarterScreen(),
//         '/second': (context) => Assignment2Start(),
//       },
//     );
//   }
// }
//
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, "/first");
//               },
//               child: const Text("Assignment 2"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, "/second");
//               },
//               child: const Text("Assignment 3"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }