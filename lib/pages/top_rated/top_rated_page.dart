import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/top_rated/widgets/top_rated_movie.dart';
import 'package:movie_app/services/api_services.dart';

class TopRatedPage extends StatefulWidget {
  const TopRatedPage({super.key});

  @override
  State<TopRatedPage> createState() => _TopRatedPageState();
}

class _TopRatedPageState extends State<TopRatedPage> {
  ApiServices apiServices = ApiServices();
  late Future<List<Movie>> movies;

  @override
  void initState() {
    movies = apiServices.getTopRated();
    super.initState();
  }

  getMoreMovies(int page) {
    setState(() {
      Future<List<Movie>> moreMoviesFuture =
          apiServices.getTopRated(page: page);
      List<Movie> moreMovies = [];
      moreMoviesFuture.then((value) => moreMovies = value);
      movies.then(
        (movies) {
          movies.addAll(moreMovies);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Top Rated Movies'),
        ),
        body: FutureBuilder(
          future: movies,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.red)),
              );
            }
            List<Movie> moviesList = snapshot.data!;
            return ListView.builder(
              itemCount: moviesList.length,
              itemBuilder: (context, index) {
                return TopRatedMovie(movie: moviesList[index]);
              },
            );
          },
        ));
  }
}
