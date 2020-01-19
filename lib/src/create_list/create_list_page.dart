import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pipok_app/src/create_list/create_list_controller.dart';
import 'package:pipok_app/src/create_list/services/movies_service.dart';
import 'package:pipok_app/src/create_list/widgets/search_movie_dialog_widget.dart';
import 'package:pipok_app/src/models/movie_list_model.dart';
import 'package:pipok_app/src/shared/auth/auth_controller.dart';
import 'package:provider/provider.dart';

class CreateListPage extends StatefulWidget {
  @override
  _CreateListPageState createState() => _CreateListPageState();
}

class _CreateListPageState extends State<CreateListPage> {
  final _nameController = TextEditingController();
  final _controller = CreateListController(
    MoviesService(
      Dio(),
    ),
  );

  @override
  void dispose() {
    _nameController.dispose();
    _controller.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthController>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar lista'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Criar'),
        onPressed: () {
          _controller.create(
            MovieListModel(
              creatorId: user.authStream.data.uid,
              name: _nameController.text,
              movies: _controller.selectedMovies,
              
              rating: 0,
            ),
          );

          Navigator.pop(context);
        },
      ),
      body: Observer(
        builder: (context) {
          return SingleChildScrollView(
            child: Form(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Nome da lista'),
                    onChanged: (value) {},
                  ),
                  RaisedButton(
                    child: Text('Adicionar filme'),
                    onPressed: () {
                      searchDialog(context, _controller);
                    },
                  ),
                  Container(
                    height: 300,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _controller.selectedMovies.length,
                      itemBuilder: (context, index) => Card(
                        child: ListTile(
                          title:
                              Text('${_controller.selectedMovies[index].name}'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> searchDialog(
          BuildContext context, CreateListController controller) =>
      showDialog(
        context: context,
        builder: (context) => SearchMovieDialogWidget(
          controller: controller,
        ),
      );
}
