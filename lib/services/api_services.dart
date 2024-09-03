import 'dart:convert';
import 'dart:io';

import 'package:movie_app/env/api.dart';
import 'package:movie_app/exception/http_exception.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {

  static const String baseURL = "https://api.themoviedb.org/3";

 Future<List<Movie>> getPopularMovies() async {
  final response = await http.get(
    Uri.parse('$baseURL/movie/popular?language=pt-BR&page=1'),
    headers: {
      HttpHeaders.authorizationHeader: Constants.apiMovieBase,
    },
  );

  if (response.statusCode == HttpStatus.ok) {
    return parseMovies(response.body);
  } else {
    throw HttpException('Falha ao carregar os filmes!');
  }
}


Future<List<Movie>> getNowPlaying() async {
  final response = await http.get(
    Uri.parse('$baseURL/movie/now_playing?language=pt-BR&page=1'),
    headers: {
      HttpHeaders.authorizationHeader: Constants.apiMovieBase,
    },
  );

  if (response.statusCode == HttpStatus.ok) {
    return parseMovies(response.body);
  } else {
    throw HttpException('Falha ao carregar os filmes!');
  }
}

Future<List<Movie>> getTopRated() async {
  final response = await http.get(
    Uri.parse('$baseURL/movie/top_rated?language=pt-BR&page=1'),
    headers: {
      HttpHeaders.authorizationHeader: Constants.apiMovieBase,
    },
  );

  if (response.statusCode == HttpStatus.ok) {
    return parseMovies(response.body);
  } else {
    throw HttpException('Falha ao carregar os filmes!');
  }
}

Future<List<Movie>> getUpcoming() async {
  final response = await http.get(
    Uri.parse('$baseURL/movie/upcoming?language=pt-BR&page=1'),
    headers: {
      HttpHeaders.authorizationHeader: Constants.apiMovieBase,
    },
  );

  if (response.statusCode == HttpStatus.ok) {
    return parseMovies(response.body);
  } else {
    throw HttpException('Falha ao carregar os filmes!');
  }
}
Future<List<Movie>> searchMovies(String query) async {
  query = cleanQuery(query);                                                                                                                                                                                                            
  final response = await http.get(
    Uri.parse('$baseURL/search/movie?query=$query&include_adult=true&language=pt_BR&page=1'),
    headers: {
      HttpHeaders.authorizationHeader: Constants.apiMovieBase,
    },
  );

  if (response.statusCode == HttpStatus.ok) {
    return parseMovies(response.body);
  } else {
    throw HttpException('Falha ao carregar os filmes!');
  }
}


String cleanQuery(String query) {
  final Map<String, String> replacements = {
    " ": "%20",
    "#": "%23",
    "&": "%26",
    "ã": "%C3%A3",
    "ç": "%C3%A7",
    "á": "%C3%A1",
    "é": "%C3%A9",
    "í": "%C3%AD",
    "ó": "%C3%B3",
    "ú": "%C3%BA",
    "â": "%C3%A2",
    "ê": "%C3%AA",
    "î": "%C3%AE",
    "ô": "%C3%B4",
    "û": "%C3%BB",
    "ü": "%C3%BC",
    "ñ": "%C3%B1"
  };

  replacements.forEach((key, value) {
    query = query.replaceAll(key, value);
  });

  return query;
}

List<Movie> parseMovies(String responseBody) {
  final parsed = jsonDecode(responseBody)['results'].cast<Map<String, dynamic>>();
  return parsed.map<Movie>((json) => Movie.fromJson(json)).toList();
}

}
