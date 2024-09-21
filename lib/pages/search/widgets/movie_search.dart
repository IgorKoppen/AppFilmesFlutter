import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/movie_details/details_sheet.dart';

class MovieSearch extends StatelessWidget {
  const MovieSearch({
    super.key,
    required this.movie,
  });

  final Movie movie;

  void showDetailsSheet(BuildContext context, int movieId) {
    showModalBottomSheet(
      context: context,
       isScrollControlled: true,
      builder: (context) => DetailsSheet(movieId: movieId),
    );
  }

  @override
  Widget build(BuildContext context) {
   const String baseUrl = 'https://image.tmdb.org/t/p/w500';
    final String fullImageUrl = movie.posterPath.isNotEmpty 
        ? '$baseUrl${movie.posterPath}' 
        : 'images/netflix.png'; 

    return GestureDetector(
        onTap: () => showDetailsSheet(context, movie.id),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: FadeInImage(
                image: NetworkImage(fullImageUrl),
                fit: BoxFit.cover,
                placeholder: const AssetImage("images/netflix.png"),
                imageErrorBuilder: (context, error, stackTrace) {
                  return const Image(image: AssetImage("images/netflix.png"));
                },
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    movie.releaseDate == null
                        ? ''
                        : DateFormat("d 'de' MMM 'de' y").format(movie.releaseDate!),
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${movie.voteAverage.toStringAsFixed(1)}/10',
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}