import 'package:flutter/material.dart';

class SignInButtonWidget extends StatelessWidget {
  const SignInButtonWidget({
    Key key,
    this.onTap,
  }) : super(key: key);

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.all(0),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Colors.red,
              Colors.red[900],
            ],
          ),
        ),
        child: Text(
          'Entre com o Google',
          style: TextStyle(color: Colors.white),
        ),
      ),
      onPressed: onTap,
    );
  }
}
