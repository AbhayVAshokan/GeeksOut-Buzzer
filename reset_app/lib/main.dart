import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData.dark(),
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),);
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
     decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/reset_background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
    );
  }
}