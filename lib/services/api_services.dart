import 'dart:convert';
import 'dart:io';

import 'package:movie_app/env/api.dart';
import 'package:movie_app/exception/http_exception.dart';
import 'package:movie_app/models/movie_details_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/movie_page_model.dart';
import 'package:movie_app/models/review_model.dart';

class ApiServices {
  static const String baseURL = "https://api.themoviedb.org/3";

Future<MoviePageModel> getPopularMovies({int page = 1}) async {
  final response = await http.get(
    Uri.parse('$baseURL/movie/popular?language=en-US&page=$page'),
    headers: {
      HttpHeaders.authorizationHeader: Constants.apiMovieBase,
    },
  );

  if (response.statusCode == HttpStatus.ok) {
    return parseMoviePage(response.body);
  } else {
    throw HttpException('Falha ao carregar os filmes!');
  }
}

 Future<MoviePageModel> getNowPlaying({int page = 1}) async {
  final response = await http.get(
    Uri.parse('$baseURL/movie/now_playing?language=en-US&page=$page'),
    headers: {
      HttpHeaders.authorizationHeader: Constants.apiMovieBase,
    },
  );

  if (response.statusCode == HttpStatus.ok) {
    return parseMoviePage(response.body);
  } else {
    throw HttpException('Falha ao carregar os filmes!');
  }
}

  Future<MoviePageModel> getTopRated({int page = 1}) async {
  final response = await http.get(
    Uri.parse('$baseURL/movie/top_rated?language=en-US&page=$page'),
    headers: {
      HttpHeaders.authorizationHeader: Constants.apiMovieBase,
    },
  );

  if (response.statusCode == HttpStatus.ok) {
    return parseMoviePage(response.body);
  } else {
    throw HttpException('Falha ao carregar os filmes!');
  }
}

  Future<MoviePageModel> getUpcoming({int page = 1}) async {
  final response = await http.get(
    Uri.parse('$baseURL/movie/upcoming?language=en-US&page=$page'),
    headers: {
      HttpHeaders.authorizationHeader: Constants.apiMovieBase,
    },
  );

  if (response.statusCode == HttpStatus.ok) {
    return parseMoviePage(response.body);
  } else {
    throw HttpException('Falha ao carregar os filmes!');
  }
}

  Future<MovieDetails> getDetailsById(int id) async{
       final response = await http.get(
      Uri.parse('$baseURL/movie/$id?language=en-US'),
      headers: {
        HttpHeaders.authorizationHeader: Constants.apiMovieBase,
      },
    );
    if (response.statusCode == HttpStatus.ok) {
      return parseMovieDetails(response.body);
    } else {
      throw HttpException('Falha ao carrega o filmes!');
    }
  }


 Future<MoviePageModel> searchMovies({int page = 1, String query = ""}) async {
  final uri =
      '$baseURL/search/movie?query=$query&include_adult=true&language=en-US&page=$page';
  final encodedUri = Uri.parse(Uri.encodeFull(uri));
  final response = await http.get(
    encodedUri,
    headers: {
      HttpHeaders.authorizationHeader: Constants.apiMovieBase,
    },
  );

  if (response.statusCode == HttpStatus.ok) {
    return parseMoviePage(response.body);
  } else {
    throw HttpException('Falha ao carregar os filmes!');
  }
}

 Future<MoviePageModel> similarMoviesByMovieId({int page = 1, required int movieId}) async {
  final uri =
      '$baseURL/movie/$movieId/similar?language=en-US&page=$page';
  final uriParsed = Uri.parse(uri);
  final response = await http.get(
    uriParsed,
    headers: {
      HttpHeaders.authorizationHeader: Constants.apiMovieBase,
    },
  );
  if (response.statusCode == HttpStatus.ok) {
    return parseMoviePage(response.body);
  } else {
    throw HttpException('Falha ao carregar os filmes!');
  }
}

Future<ReviewPageModel> getReviewsOfMovieById({int page = 1, required int movieId}) async {
   final uri =
      '$baseURL/movie/$movieId/reviews?language=en-US&page=$page';
  final uriParsed = Uri.parse(uri);
  final response = await http.get(
    uriParsed,
    headers: {
      HttpHeaders.authorizationHeader: Constants.apiMovieBase,
    },
  );
  if (response.statusCode == HttpStatus.ok) {
    return parseReviewsPageModel(response.body);
  } else {
    throw HttpException('Falha ao carregar as reviews do filme $movieId! ');
  }
}



  ReviewPageModel parseReviewsPageModel(String responseBody) {
    final parsed = jsonDecode(responseBody) as Map<String, dynamic>;
    return ReviewPageModel.fromJson(parsed);
  }



 MovieDetails parseMovieDetails(String responseBody) {
  final parsed = jsonDecode(responseBody) as Map<String, dynamic>;
  return MovieDetails.fromJson(parsed);
}

MoviePageModel parseMoviePage(String responseBody) {
  final parsed = jsonDecode(responseBody) as Map<String, dynamic>;
  return MoviePageModel.fromJson(parsed);
}

  List<Movie> parseMovies(String responseBody) {
    final parsed =
        jsonDecode(responseBody)['results'].cast<Map<String, dynamic>>();
    return parsed.map<Movie>((json) => Movie.fromJson(json)).toList();
  }
}
