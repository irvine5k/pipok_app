import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pipok_app/src/home/home_page.dart';
import 'package:pipok_app/src/shared/auth/auth_controller.dart';
import 'package:pipok_app/src/sign_in/sign_in_page.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final _authController = Provider.of<AuthController>(context);

    return Observer(
      builder: (context) {
        if (_authController.authStream.data == null) {
          return SignInPage();
        }

        return HomePage();
      },
    );
  }
}
