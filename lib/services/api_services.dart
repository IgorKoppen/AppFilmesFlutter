import 'dart:convert';
import 'dart:io';

import 'package:movie_app/env/api.dart';
import 'package:movie_app/exception/http_exception.dart';
import 'package:movie_app/models/movie_datails.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String baseURL = "https://api.themoviedb.org/3";

  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    final response = await http.get(
      Uri.parse('$baseURL/movie/popular?language=pt-BR&page=$page'),
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

  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await http.get(
      Uri.parse('$baseURL/movie/now_playing?language=pt-BR&page=$page'),
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

  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await http.get(
      Uri.parse('$baseURL/movie/top_rated?language=pt-BR&page=$page'),
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

  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await http.get(
      Uri.parse('$baseURL/movie/upcoming?language=pt-BR&page=$page'),
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

  Future<MovieDetails> getDetailsById(int id) async{
       final response = await http.get(
      Uri.parse('$baseURL/movie/$id?language=pt_BR'),
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


  Future<List<Movie>> searchMovies({int page = 1, String query = ""}) async {
    final uri =
        '$baseURL/search/movie?query=$query&include_adult=true&language=pt_BR&page=$page';
    final encodedUri = Uri.parse(Uri.encodeFull(uri));
    final response = await http.get(
      encodedUri,
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
 MovieDetails parseMovieDetails(String responseBody) {
  final parsed = jsonDecode(responseBody) as Map<String, dynamic>;
  return MovieDetails.fromJson(parsed);
}


  List<Movie> parseMovies(String responseBody) {
    final parsed =
        jsonDecode(responseBody)['results'].cast<Map<String, dynamic>>();
    return parsed.map<Movie>((json) => Movie.fromJson(json)).toList();
  }
}
