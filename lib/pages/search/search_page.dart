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
  List<Movie> movies = [];
  List<Movie> filterMovies = [];

  @override
  void initState() {
    movies = apiServices.getMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
                  onChanged: (value) {
                    setState(() {
                      filterMovies = movies
                          .where((element) => element.originalTitle == value)
                          .toList();
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Search'),
            ],
          ),
        ),
      ),
    );
  }
}
