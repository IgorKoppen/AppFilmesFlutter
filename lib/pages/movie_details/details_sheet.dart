import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_details_model.dart';
import 'package:movie_app/pages/movie_details/movie_details_page.dart';
import 'package:movie_app/services/api_services.dart';

class DetailsSheet extends StatefulWidget {
  final int movieId;
  final bool isToShowSimilarButton;
  const DetailsSheet({super.key,
   required this.movieId,
    this.isToShowSimilarButton = true});
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
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final movie = snapshot.data!;
          return MovieDetailsPage(movie: movie, similarButtonShow: widget.isToShowSimilarButton,);
        } else {
          return const Center(child: Text('No data available',
          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.red
                          )));
        }
      },
    );
  }
}