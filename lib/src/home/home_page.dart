import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pipok_app/src/home/widgets/movie_list/movie_list_widget.dart';
import 'package:pipok_app/src/shared/auth/auth_controller.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _authController = Provider.of<AuthController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: _authController.signOut,
          ),
        ],
      ),
      body: Observer(
        builder: (context) {
          if (_authController.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: <Widget>[MovieListWidget()],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('CRIAR LISTA'),
        icon: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
