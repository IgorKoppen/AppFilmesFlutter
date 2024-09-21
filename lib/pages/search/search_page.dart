import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/movie_page_model.dart';
import 'package:movie_app/pages/search/widgets/movie_search.dart';
import 'package:movie_app/services/api_services.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  ApiServices apiServices = ApiServices();
  String search = "";
  List<Movie> moviesList = [];
  int currentPage = 1;
  bool isLoading = false;
  bool hasMorePages = true;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener); 
    _fetchMoreMovies(); 
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent && !isLoading) {
      _fetchMoreMovies();
    }
  }

  Future<void> _fetchMoreMovies() async {
    if (isLoading || !hasMorePages) return;

    setState(() {
      isLoading = true;
    });

    try {
      final moviePage = await apiServices.searchMovies(query: search, page: currentPage);
      if (!mounted) return;

      setState(() {
        moviesList.addAll(moviePage.results);
        currentPage++;
        if (currentPage > moviePage.totalPages) {
          hasMorePages = false; 
        }
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao carregar mais filmes: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void findSearch(String search) {
    setState(() {
      this.search = search;
      currentPage = 1;
      moviesList.clear();
      hasMorePages = true;
      _fetchMoreMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CupertinoSearchTextField(
                padding: const EdgeInsets.all(10.0),
                prefixIcon: const Icon(
                  CupertinoIcons.search,
                  color: Colors.grey,
                ),
                suffixIcon: const Icon(
                  Icons.cancel,
                  color: Colors.grey,
                ),
                style: const TextStyle(color: Colors.white),
                backgroundColor: Colors.grey.withOpacity(0.3),
                onSubmitted: (value) {
                  findSearch(value);
                },
              ),
            ),
            const SizedBox(height: 10),
            const Text('Search'),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: moviesList.length + (isLoading ? 1 : 0), 
                itemBuilder: (context, index) {
                  if (index == moviesList.length) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return MovieSearch(movie: moviesList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}