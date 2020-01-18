import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ENTRAR'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: RaisedButton(
                color: Colors.red,
                child: Text(
                  'Entre com o Google',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
