import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:pipok_app/src/models/movie_list_model.dart';

part 'movie_list_controller.g.dart';

class MovieListController = _MovieListController with _$MovieListController;

abstract class _MovieListController with Store {
  final _firestore = Firestore();
  
  CollectionReference get _collection => _firestore.collection('lists');

  @computed
  ObservableStream<List<MovieListModel>> get movieListsStream => _firestore
      .collection('lists')
      .snapshots()
      .map(
        (snapshot) => snapshot.documents
            .map(
              (document) => MovieListModel.fromMap(
                document.data,
              ),
            )
            .toList(),
      )
      .asObservable();

  void add(MovieListModel model) => _collection.add(
        model.toMap(),
      );

  void update(String documentId, MovieListModel model) =>
      _collection.document(documentId).updateData(
            model.toMap(),
          );

  void delete(String documentId) => _collection.document(documentId).delete();
}
