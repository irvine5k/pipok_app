class MovieListModel {
  final String id;
  final String name;
  final String creatorId;
  final List<MovieModel> movies;
  final List<String> favorites;

  MovieListModel({
    this.id,
    this.name,
    this.creatorId,
    this.movies,
    this.favorites,
  });

  String get imageUrl => movies.first.image;

  int get favoritesCount => favorites.length;

  bool isFavorited(String userId) => favorites.contains(userId);

  factory MovieListModel.fromMap(Map<String, dynamic> map, String id) => MovieListModel(
        id: id,
        name: map['name'],
        creatorId: map['creatorId'],
        movies: List<MovieModel>.from(
          map['movies'].map(
            (movie) => MovieModel(
              name: movie['name'],
              description: movie['description'],
              genres: movie['genres'].cast<String>(),
              image: movie['image'],
            ),
          ),
        ),
        favorites: map['favorites'].cast<String>(),
      );

  Map<String, dynamic> toMap() => {
        'name': this.name,
        'creatorId': this.creatorId,
        'movies': this.movies.map((movie) => movie.toMap()).toList(),
        'favorites': <String>[],
      };
}

class MovieModel {
  final String name;
  final String description;
  final List<String> genres;
  final String image;

  MovieModel({
    this.name,
    this.description,
    this.genres = const [],
    this.image,
  });

  Map<String, dynamic> toMap() => {
        'name': this.name,
        'description': this.description,
        'genres': this.genres ?? [],
        'image': this.image,
      };

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        image: json["poster_path"],
        name: json["title"],
        description: json["overview"],
      );
}
