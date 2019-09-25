import 'package:expense_manager/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal Exppenses",
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(title: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20
          ),
        ),
      ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
