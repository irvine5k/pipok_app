// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MovieListController on _MovieListController, Store {
  Computed<ObservableStream<List<MovieListModel>>> _$movieListsStreamComputed;

  @override
  ObservableStream<List<MovieListModel>> get movieListsStream =>
      (_$movieListsStreamComputed ??=
              Computed<ObservableStream<List<MovieListModel>>>(
                  () => super.movieListsStream))
          .value;
}
