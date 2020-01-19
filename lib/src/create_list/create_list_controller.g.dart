// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CreateListController on _CreateListController, Store {
  final _$resultsAtom = Atom(name: '_CreateListController.results');

  @override
  ObservableStream<List<MovieModel>> get results {
    _$resultsAtom.context.enforceReadPolicy(_$resultsAtom);
    _$resultsAtom.reportObserved();
    return super.results;
  }

  @override
  set results(ObservableStream<List<MovieModel>> value) {
    _$resultsAtom.context.conditionallyRunInAction(() {
      super.results = value;
      _$resultsAtom.reportChanged();
    }, _$resultsAtom, name: '${_$resultsAtom.name}_set');
  }

  final _$selectedMoviesAtom =
      Atom(name: '_CreateListController.selectedMovies');

  @override
  ObservableList<MovieModel> get selectedMovies {
    _$selectedMoviesAtom.context.enforceReadPolicy(_$selectedMoviesAtom);
    _$selectedMoviesAtom.reportObserved();
    return super.selectedMovies;
  }

  @override
  set selectedMovies(ObservableList<MovieModel> value) {
    _$selectedMoviesAtom.context.conditionallyRunInAction(() {
      super.selectedMovies = value;
      _$selectedMoviesAtom.reportChanged();
    }, _$selectedMoviesAtom, name: '${_$selectedMoviesAtom.name}_set');
  }

  final _$_CreateListControllerActionController =
      ActionController(name: '_CreateListController');

  @override
  void selectMovie(MovieModel movie) {
    final _$actionInfo = _$_CreateListControllerActionController.startAction();
    try {
      return super.selectMovie(movie);
    } finally {
      _$_CreateListControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeMovie(MovieModel movie) {
    final _$actionInfo = _$_CreateListControllerActionController.startAction();
    try {
      return super.removeMovie(movie);
    } finally {
      _$_CreateListControllerActionController.endAction(_$actionInfo);
    }
  }
}
