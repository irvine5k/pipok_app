import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:pipok_app/src/models/movie_list_model.dart';

part 'personal_lists_controller.g.dart';

class PersonalListsController = _PersonalListsController
    with _$PersonalListsController;

abstract class _PersonalListsController with Store {
  final FirebaseUser user;
  final _firestore = Firestore();
  CollectionReference get _collection => _firestore.collection('lists');

  _PersonalListsController(this.user);

  @computed
  ObservableStream<List<MovieListModel>> get personalListsStream => _firestore
      .collection('lists')
      .snapshots()
      .map(
        (snapshot) => snapshot.documents
            .map(
              (document) => MovieListModel.fromMap(
                document.data,
              ),
            )
            .where(
              (list) => list.creatorId == user.uid,
            )
            .toList(),
      )
      .asObservable();

  void add(MovieListModel model) => _collection.add(model.toMap());
}
