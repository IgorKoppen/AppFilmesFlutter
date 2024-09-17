import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_datails.dart';
import 'package:movie_app/services/api_services.dart';

class DetailsSheet extends StatefulWidget {
  final int movieId;
  const DetailsSheet({super.key, required this.movieId});

  @override
  State<DetailsSheet> createState() => _DetailsSheetState();
}

class _DetailsSheetState extends State<DetailsSheet> {
  final ApiServices apiServices = ApiServices();
  late Future<MovieDetails> movieDetails;

    @override
  void initState() {
    movieDetails = apiServices.getDetailsById(widget.movieId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieDetails>(
      future: movieDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return  const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final movie = snapshot.data!;
          return FractionallySizedBox(
            heightFactor: 0.8,
            widthFactor: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
            
                children: [
                  Text(movie.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                 const SizedBox(height: 8),
                  Text('Release Date: ${movie.releaseDate}'),
                 const SizedBox(height: 8),
                  Text('Overview: ${movie.overview}'),
                const  SizedBox(height: 8),
                  Text('Genres: ${movie.genres.map((genre) => genre.name).join(', ')}'),
                 const SizedBox(height: 8),
                  Text('Vote Average: ${movie.voteAverage}'),
                const  SizedBox(height: 8),
                  Text('Vote Count: ${movie.voteCount}'),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
