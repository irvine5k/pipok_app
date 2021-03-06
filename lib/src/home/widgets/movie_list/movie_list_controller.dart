import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:pipok_app/src/models/movie_list_model.dart';

part 'movie_list_controller.g.dart';

class MovieListController = _MovieListController with _$MovieListController;

abstract class _MovieListController with Store {
  final _firestore = Firestore();

  @computed
  ObservableStream<List<MovieListModel>> get movieListsStream => _firestore
      .collection('lists')
      .snapshots()
      .map(
        (snapshot) => snapshot.documents
            .map(
              (document) => MovieListModel.fromMap(
                document.data,
                document.documentID,
              ),
            )
            .toList()
              ..sort(
                (a, b) => b.favorites.length.compareTo(a.favorites.length),
              ),
      )
      .asObservable();

  void favorite(String documentId, String uuid) =>
      _firestore.collection('lists').document(documentId).setData(
        {
          'favorites': [uuid],
        },
        merge: true,
      );

  void unfavorite(String documentId, String uuid) =>
      _firestore.collection('lists').document(documentId).updateData(
        {
          'favorites': FieldValue.arrayRemove(
            [uuid],
          )
        },
      );
}
