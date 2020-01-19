import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pipok_app/src/create_list/create_list_page.dart';
import 'package:pipok_app/src/home/widgets/movie_list/movie_list_widget.dart';
import 'package:pipok_app/src/models/movie_list_model.dart';
import 'package:pipok_app/src/personal_lists/widgets/personal_lists/personal_lists_controller.dart';
import 'package:pipok_app/src/personal_lists/widgets/personal_lists/personal_lists_widget.dart';
import 'package:pipok_app/src/shared/auth/auth_controller.dart';
import 'package:provider/provider.dart';

class PersonalListsPage extends StatefulWidget {
  @override
  _PersonalListsPageState createState() => _PersonalListsPageState();
}

class _PersonalListsPageState extends State<PersonalListsPage> {
  AuthController _authController;
  PersonalListsController _personalListsController;

  @override
  Widget build(BuildContext context) {
    _authController ??= Provider.of<AuthController>(context);

    _personalListsController ??=
        PersonalListsController(_authController.authStream.data);

    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas listas'),
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
            children: <Widget>[
              PersonalListsWidget(
                controller: _personalListsController,
              )
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('CRIAR LISTA'),
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateListPage()));
        },
      ),
    );
  }
}
