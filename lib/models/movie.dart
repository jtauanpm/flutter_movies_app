class Movie {
  String? title;
  String? poster;

  Movie({required this.title, required this.poster});

  Movie.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    poster = json['Poster'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Title'] = title;
    data['Poster'] = poster;
    return data;
  }
}
