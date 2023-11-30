class Movie {
  final int id;
  final String title;
  final String overview;
  final String releaseDate;
  final double voteAverage;
  final String posterPath;
  final double popularity;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.posterPath,
    required this.popularity,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      voteAverage: json['vote_average'].toDouble(),
      posterPath: json['poster_path'],
      popularity: json['popularity'].toDouble(),
    );
  }
}
