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
          child: Center(
            child: Text('Em breve'),
          ),
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
      backgroundColor: Colors.black,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'LISTAS',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.yellow),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.exit_to_app,
                          size: 30,
                          color: Colors.yellow,
                        ),
                        onPressed: _authController.signOut,
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  buildTabs(),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              // color: Colors.blueGrey[50],
              child: _buildTab(),
            ),
          ),
        ],
      ),
      floatingActionButton: tab == 2
          ? FloatingActionButton.extended(
              backgroundColor: Colors.yellow,
              icon: Icon(
                Icons.add,
                color: Colors.black,
              ),
              label: Text(
                'CRIAR LISTA',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
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
      child: Container(
        padding: isSelected
            ? EdgeInsets.symmetric(horizontal: 10, vertical: 5)
            : null,
        decoration: BoxDecoration(
          color: isSelected ? Colors.yellow : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: isSelected ? 16 : 14,
              color: isSelected ? Colors.black : Colors.white),
        ),
      ),
      onTap: onTap,
    );
  }
}
