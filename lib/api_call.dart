class Movie {
  final String title;
  final String year;
  final String released;
  final String director;
  final String language;
  final String awards;
  final String poster;
  final String imdbRating;
  final String type;
  final String boxOffice;
  final String response;

  Movie({
    required this.title,
    required this.year,
    required this.released,
    required this.director,
    required this.language,
    required this.awards,
    required this.poster,
    required this.imdbRating,
    required this.type,
    required this.boxOffice,
    required this.response,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'] ?? "",
      year: json['Year'] ?? "",
      released: json['Released'] ?? "",
      director: json['Director'] ?? "",
      language: json['Language'] ?? "",
      awards: json['Awards'] ?? "",
      poster: json['Poster'] ?? "",
      imdbRating: json['imdbRating'] ?? "",
      type: json['Type'] ?? "",
      boxOffice: json['BoxOffice'] ?? "",
      response: json['Response'] ?? "",
    );
  }
}
