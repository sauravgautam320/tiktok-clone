import 'package:flutter/material.dart';
import './screen/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Its Ur Show',
      home: HomeScreen(),
      theme: ThemeData.dark(),
    );
  }
}
