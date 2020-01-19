import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:pipok_app/src/create_list/services/movies_service.dart';
import 'package:pipok_app/src/models/movie_list_model.dart';
import 'package:rxdart/rxdart.dart';
part 'create_list_controller.g.dart';

class CreateListController = _CreateListController with _$CreateListController;

abstract class _CreateListController with Store {
  final collection = Firestore().collection('lists');

  final MoviesService moviesService;

  _CreateListController(this.moviesService) {
    _results = _query
        .distinct()
        .where((e) => e.length >= 3)
        .debounceTime(Duration(milliseconds: 250))
        .switchMap(
          (query) => _page
              .startWith(0)
              .mapTo(1)
              .scan((acc, curr, i) => acc + curr, 0)
              .asyncMap(
                (i) => moviesService.search(query, i),
              )
              .scan<List<MovieModel>>(
                  (acc, curr, i) => acc..addAll(List.from(curr)), []),
        );

    _results.listen(print);
    _query.listen(print);

    results = _results.asObservable();
  }
  final _query = BehaviorSubject<String>();
  final _page = BehaviorSubject<int>();

  Stream<List<MovieModel>> _results;

  Sink<String> get setQuery => _query.sink;
  Sink get setPage => _page.sink;

  @observable
  ObservableStream<List<MovieModel>> results;

  @observable
  ObservableList<MovieModel> selectedMovies = <MovieModel>[].asObservable();

  @action
  void selectMovie(MovieModel movie) {
    if (selectedMovies.contains(movie)) return;

    selectedMovies.add(movie);
  }

  @action
  void removeMovie(MovieModel movie) => selectedMovies.remove(movie);

  void create(MovieListModel model) => collection.add(model.toMap());

  void dispose() async {
    await _query.close();
    await _page.close();
  }
}
