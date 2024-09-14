class Movie {
  final String id;
  final String? title;
  final String? image;
  final String? duration;
  final String? releaseDate;

  const Movie({
    required this.id,
    this.title,
    this.image,
    this.duration,
    this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['imdbID'] as String,
      title: json['Title'] as String?,
      image: json['Poster'] as String?,
      duration: json['Runtime'] as String?,
      releaseDate: json['Released'] as String?,
    );
  }
}
