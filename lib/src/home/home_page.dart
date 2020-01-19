import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pipok_app/src/home/widgets/movie_list/movie_list_widget.dart';
import 'package:pipok_app/src/personal_lists/personal_lists_page.dart';
import 'package:pipok_app/src/personal_lists/widgets/personal_lists/personal_lists_controller.dart';
import 'package:pipok_app/src/personal_lists/widgets/personal_lists/personal_lists_widget.dart';
import 'package:pipok_app/src/shared/auth/auth_controller.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthController _authController;
  PersonalListsController _personalListsController;

  int tab = 0;

  Widget buildTabs() => Row(
        children: <Widget>[
          TabItemWidget(
            label: 'NOVAS',
            index: 0,
            onTap: () {
              setState(() {
                tab = 0;
              });
            },
            isSelected: tab == 0,
          ),
          SizedBox(width: 5),
          TabItemWidget(
            label: 'POPULARES',
            index: 1,
            onTap: () {
              setState(() {
                tab = 1;
              });
            },
            isSelected: tab == 1,
          ),
          SizedBox(width: 5),
          TabItemWidget(
            label: 'MINHAS LISTAS',
            index: 2,
            onTap: () {
              setState(() {
                tab = 2;
              });
            },
            isSelected: tab == 2,
          ),
        ],
      );

  Widget _buildTab() {
    switch (tab) {
      case 0:
        return Container(
          color: Colors.red,
        );
        break;
      case 1:
        return Container(
          child: MovieListWidget(),
        );

        break;
      case 2:
        return PersonalListsWidget(
          controller: _personalListsController,
        );

        break;
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    _authController ??= Provider.of<AuthController>(context);

    _personalListsController ??=
        PersonalListsController(_authController.authStream.data);

    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              // alignment: Alignment.bottomLeft,
              padding: EdgeInsets.symmetric(horizontal: 20),
              // color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'LISTAS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 10),
                  buildTabs(),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.blueGrey[50],
              child: _buildTab(),
            ),
          ),
        ],
      ),
      floatingActionButton: tab == 2
          ? FloatingActionButton.extended(
              backgroundColor: Colors.black,
              icon: Icon(Icons.add),
              label: Text('CRIAR LISTA'),
              onPressed: () {},
            )
          : null,
    );
  }
}

class TabItemWidget extends StatelessWidget {
  final int index;
  final bool isSelected;
  final String label;
  final Function onTap;

  const TabItemWidget({
    Key key,
    this.index,
    this.label,
    this.isSelected,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(
        label,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: onTap,
    );
  }
}
