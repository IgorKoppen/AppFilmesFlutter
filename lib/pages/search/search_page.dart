import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
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
   late Future<List<Movie>> searchMovies;

  findSearch(String search){
    searchMovies = apiServices.searchMovies(search);
  }
  
    @override
  void initState() {
    searchMovies = apiServices.getNowPlaying();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
  body: SafeArea(
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
        children: [
          const SizedBox(
            height: 10,
          ),
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
                setState(() {
                  findSearch(value);
                });
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text('Search'),
          FutureBuilder(
            future: searchMovies,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                );
              }
              List<Movie> moviesList = snapshot.data!;
              return Flexible(
                fit: FlexFit.loose, // Use Flexible with FlexFit.loose
                child: ListView.builder(
                  shrinkWrap: true, // Ensure ListView is shrink-wrapped
                  itemCount: moviesList.length,
                  itemBuilder: (context, index) {
                    return MovieSearch(movie: moviesList[index]);
                  },
                ),
              );
            },
          ),
        ],
      ),
    ),
  ),
);
  }
  }