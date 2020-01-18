import 'package:flutter/material.dart';
import 'package:pipok_app/src/home/home_page.dart';
import 'package:pipok_app/src/sign_in/sign_in_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: SignInPage(),
    );
  }
}
