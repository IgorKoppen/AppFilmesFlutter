import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/models/movie_details_model.dart';
import 'package:movie_app/pages/movie_details/widgets/custom_button.dart';
import 'package:movie_app/pages/movie_details/widgets/stars.dart';
import 'package:movie_app/pages/reviewsMovie/review_page.dart';
import 'package:movie_app/pages/similar/similar_page.dart';

class MovieDetailsPage extends StatelessWidget {
  final MovieDetails movie;
  final String baseUrl = 'https://image.tmdb.org/t/p/w500';
  final String placeholderImage =
      'images/500x300-placeholder.png';
  final bool similarButtonShow;

  const MovieDetailsPage(
      {super.key, required this.movie, this.similarButtonShow = true});

  String get posterUrl => movie.backdropPath != null
      ? '$baseUrl${movie.backdropPath}'
      : placeholderImage;

  String formatDateString(String dateString) {
    final DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.85,
      widthFactor: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(posterUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Genres:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 5.0,
                          runSpacing: 5.0,
                          children: movie.genres.isNotEmpty
                              ? movie.genres.map((genre) {
                                  return Chip(
                                    label: Text(genre.name),
                                  );
                                }).toList()
                              : [const Chip(label: Text('N/A'))],
                        ),
                        const SizedBox(height: 22),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                'Release Date: ${movie.releaseDate.isNotEmpty ? formatDateString(movie.releaseDate) : 'N/A'}',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.thumb_up),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                  'Vote Average: ${movie.voteAverage.toStringAsFixed(1)}'),
                            ),
                            Expanded(
                              child: Text('Vote Count: ${movie.voteCount}'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        StarsBuild(rating: movie.voteAverage),
                        const SizedBox(height: 16),
                        const Text(
                          'Synopsis:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          movie.overview.isNotEmpty
                              ? movie.overview
                              : 'No synopsis available.',
                          style: const TextStyle(fontSize: 13),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.trending_up),
                            const SizedBox(width: 16),
                            Text('Popularity: ${movie.popularity.toString()}'),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.info),
                            const SizedBox(width: 10),
                            Text('Status: ${movie.status}'),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.label),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text('Tagline: ${movie.tagline ?? 'N/A'}'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.access_time),
                            const SizedBox(width: 10),
                            Text(
                                'Runtime: ${movie.runtime > 0 ? '${movie.runtime} minutes' : 'N/A'}'),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(Icons.business),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Production Companies: ${movie.productionCompanies.isNotEmpty ? movie.productionCompanies.map((company) => company.name).join(', ') : 'N/A'}',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        if (similarButtonShow)
                          Row(
                            children: [
                              CustomButton(
                                text: 'Similar Movies',
                                icon: Icons.search,
                                color: Colors.purple,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SimilarPage(movieId: movie.id),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 20),
                                  CustomButton(
                                text: 'Reviews',
                                icon: Icons.reviews,
                                color: Colors.purple,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ReviewPage(movieId: movie.id),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
