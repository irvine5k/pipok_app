import 'package:flutter/material.dart';
import 'package:pipok_app/src/home/home_page.dart';
import 'package:pipok_app/src/landing/landing_page.dart';
import 'package:pipok_app/src/shared/auth/auth_controller.dart';
import 'package:pipok_app/src/sign_in/sign_in_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => AuthController()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LandingPage(),
      ),
    );
  }
}
