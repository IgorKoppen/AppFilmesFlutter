import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/home/widgets/movie_horizontal_item.dart';
import 'package:movie_app/pages/home/widgets/movie_horizontal_placeholder.dart';

class MoviesHorizontalList extends StatelessWidget {
  final List<Movie> movies;
  final int placeholdCount = 6;

  const MoviesHorizontalList({super.key,required this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
      height: 230,
      child: ListView.builder(
       scrollDirection: Axis.horizontal,
        itemCount: movies.isEmpty ?  placeholdCount : movies.length,
        itemBuilder: (context, index) {
          if(movies.isEmpty){
            return const MovieHorizontalPlaceholder();
          }
          return MovieHorizontalItem(movie: movies[index]);
        },
      ),
    );
  }
}
