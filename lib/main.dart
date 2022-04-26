import 'package:flutter/material.dart';
import 'package:tenor_gifs/pages/MainPage.dart';
import 'package:tenor_gifs/pages/happy.dart';
import 'package:tenor_gifs/pages/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(),
    );
  }
}
