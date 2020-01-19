import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pipok_app/src/models/movie_list_model.dart';

import 'movie_list_controller.dart';

class MovieListWidget extends StatefulWidget {
  @override
  _MovieListWidgetState createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final _movieListController = MovieListController();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (_movieListController.movieListsStream.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Expanded(
          child: ListView.builder(
            itemCount: _movieListController.movieListsStream.data.length,
            itemBuilder: (context, index) => Card(
              child: ListTile(
                title: Text(
                  _movieListController.movieListsStream.data[index].name,
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
