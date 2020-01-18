import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pipok_app/src/shared/auth/auth_controller.dart';
import 'package:pipok_app/src/sign_in/widgets/sign_in_button_widget.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    final _authController = Provider.of<AuthController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('ENTRAR'),
      ),
      body: SafeArea(
        child: Observer(builder: (context) {
          if (_authController.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SignInButtonWidget(
                  onTap: _authController.signInAnonymously,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
