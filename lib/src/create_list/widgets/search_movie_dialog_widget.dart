import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pipok_app/src/create_list/create_list_controller.dart';
import 'package:pipok_app/src/models/movie_list_model.dart';

class SearchMovieDialogWidget extends StatelessWidget {
  final CreateListController controller;

  const SearchMovieDialogWidget({Key key, @required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: EdgeInsets.all(40),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Observer(builder: (context) {
          print(controller.results.data);

          final List<MovieModel> movies = controller?.results?.data ?? [];

          return Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: 'Pesquise o filme'),
                onChanged: controller.setQuery.add,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: movies.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Card(
                    child: ListTile(
                      title: Text(movies[index].name),
                      onTap: () {
                        controller.selectMovie(movies[index]);

                        Navigator.pop(context);
                      },
                    ),
                    
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
