import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/top_rated/widgets/top_rated_movie.dart';
import 'package:movie_app/services/api_services.dart';

class SimilarPage extends StatefulWidget {
  final int movieId;

  const SimilarPage({super.key, required this.movieId});

  @override
  State<SimilarPage> createState() => _SimilarPageState();
}

class _SimilarPageState extends State<SimilarPage> {
  final ApiServices apiServices = ApiServices();
  List<Movie> moviesList = [];
  int currentPage = 1; 
  bool isLoading = false; 
  bool hasMorePages = true; 
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _fetchMovies(); 
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchMovies() async {
    if (isLoading || !hasMorePages) return; 
    setState(() {
      isLoading = true;
    });

    try {
      final moviePage = await apiServices.similarMoviesByMovieId(page: currentPage, movieId: widget.movieId);
      setState(() {
        moviesList.addAll(moviePage.results);
        currentPage++;
        if (currentPage > moviePage.totalPages) {
          hasMorePages = false; 
        }
      });
    } catch (e) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('An error occurred while trying to load the movies.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.9 &&
        !isLoading) {
      _fetchMovies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Similar Movies'),
      ),
      body: moviesList.isEmpty && isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              controller: _scrollController,
              itemCount: moviesList.length + (isLoading ? 1 : 0), 
              itemBuilder: (context, index) {
                if (index == moviesList.length) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return MovieCard(movie: moviesList[index],isToShowSimilarButton: false,);
              },
            ),
    );
  }
}