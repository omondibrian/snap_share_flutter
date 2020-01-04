


import 'package:flutter/material.dart';
import 'package:test_flutter/Screens/Home_screen.dart';

void main()=>runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "chat ui",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Color(0xFFFEF9EB)
      ),
      
      home: HomeScreen(),
    );
  }
}