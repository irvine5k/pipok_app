import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pipok_app/src/models/movie_list_model.dart';
import 'package:pipok_app/src/shared/auth/auth_controller.dart';
import 'package:provider/provider.dart';

import 'movie_list_controller.dart';

class MovieListWidget extends StatefulWidget {
  @override
  _MovieListWidgetState createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final _movieListController = MovieListController();

  @override
  Widget build(BuildContext context) {
    final _authController = Provider.of<AuthController>(context);

    return Observer(
      builder: (context) {
        if (_movieListController.movieListsStream.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: .8,
            ),
            itemCount: _movieListController.movieListsStream.data.length,
            itemBuilder: (context, index) => Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      'http://image.tmdb.org/t/p/w185/'
                      '${_movieListController.movieListsStream.data[index].imageUrl}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black54,
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            _movieListController.movieListsStream.data[index]
                                    .isFavorited(
                                        _authController.authStream.data.uid)
                                ? _movieListController.unfavorite(
                                    _movieListController
                                        .movieListsStream.data[index].id,
                                    _authController.authStream.data.uid,
                                  )
                                : _movieListController.favorite(
                                    _movieListController
                                        .movieListsStream.data[index].id,
                                    _authController.authStream.data.uid,
                                  );
                          },
                          icon: Icon(
                            _movieListController.movieListsStream.data[index]
                                    .isFavorited(
                                        _authController.authStream.data.uid)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.only(left: 20, bottom: 15),
                        child: Text(
                          '${_movieListController.movieListsStream.data[index].name}'.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        padding: EdgeInsets.only(right: 20, bottom: 15),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            '${_movieListController.movieListsStream.data[index].favorites.length}',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
