class MovieListModel {
  final String name;
  final String creatorId;
  final double rating;
  final List<MovieModel> movies;

  MovieListModel({
    this.name,
    this.creatorId,
    this.rating,
    this.movies,
  });

  factory MovieListModel.fromMap(Map<String, dynamic> map) => MovieListModel(
        name: map['name'],
        creatorId: map['creatorId'],
        rating: double.parse(map['rating'].toString()),
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
      );

  Map<String, dynamic> toMap() => {
        'name': this.name,
        'creatorId': this.creatorId,
        'rating': this.rating,
        'movies': this.movies.map((movie) => movie.toMap()).toList(),
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
