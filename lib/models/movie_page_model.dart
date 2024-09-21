import 'package:movie_app/models/movie_model.dart';

class MoviePageModel {
  final String? maximumDate;
  final String? minimumDate;
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  MoviePageModel({
    this.maximumDate,
    this.minimumDate,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MoviePageModel.fromJson(Map<String, dynamic> json) {

    final dates = json['dates'];
    
    return MoviePageModel(
      maximumDate: dates != null ? dates['maximum'] : null,
      minimumDate: dates != null ? dates['minimum'] : null,
      page: json['page'],
      results: List<Movie>.from(json['results'].map((movie) => Movie.fromJson(movie))),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}