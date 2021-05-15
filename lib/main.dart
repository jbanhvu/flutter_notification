
import 'package:flutter/material.dart';
import 'package:notification/GodWord/Retrieving_data.dart';
import 'package:notification/GodWord/Retrieving_data2.dart';

void  main()async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        // backgroundColor: Colors.white,
        //scaffoldBackgroundColor: Colors.white,
        // We apply this to our appBarTheme because most of our appBar have this style
        //appBarTheme: AppBarTheme(color: Colors.white, elevation: 0),
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Retrieving(),
    );
  }
}