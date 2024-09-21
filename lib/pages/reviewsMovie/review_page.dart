import 'package:flutter/material.dart';
import 'package:movie_app/models/review_model.dart';
import 'package:movie_app/pages/movie_details/widgets/stars.dart';
import 'package:movie_app/services/api_services.dart';


class ReviewPage extends StatefulWidget {
  final int movieId;
  const ReviewPage({super.key, required this.movieId});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final ApiServices apiServices = ApiServices();
  late Future<ReviewPageModel> review;

  @override
  void initState() {
    review = apiServices.getReviewsOfMovieById(movieId: widget.movieId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
      ),
      body: FutureBuilder<ReviewPageModel>(
        future: review,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.results.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data?.results.length ?? 0,
              itemBuilder: (context, index) {
                final review = snapshot.data!.results[index];
                final avatarPath = review.authorDetails.avatarPath;
                final rating = review.authorDetails.rating;
                
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0), 
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: avatarPath != null
                            ? NetworkImage(
                                'https://image.tmdb.org/t/p/w500$avatarPath')
                            : const AssetImage('images/default_avatar.png')
                                as ImageProvider,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review.author,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Rating: ${rating != null ? rating.toString() : 'N/A'}/10',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              if(rating != null)
                              StarsBuild(rating: rating.toDouble()),
                              const SizedBox(height: 6),
                              Text(
                                review.content,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Created at: ${review.createdAt}',
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No Reviews Available'));
          }
        },
      ),
    );
  }
}