import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_page_model.dart';
import 'package:movie_app/pages/home/widgets/movies_horizontal_list.dart';
import 'package:movie_app/pages/home/widgets/nowplaying_list.dart';
import 'package:movie_app/services/api_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiServices apiServices = ApiServices();
  late Future<MoviePageModel> nowPlayingMovies;
  late Future<MoviePageModel> upcomingMovies;
  late Future<MoviePageModel> popularMovies;
  
  @override
  void initState() {
    nowPlayingMovies = apiServices.getNowPlaying();
    upcomingMovies = apiServices.getUpcoming();
    popularMovies = apiServices.getPopularMovies();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  'Now Playing',
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                ),
              ),
              FutureBuilder(
                future: nowPlayingMovies,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: NowPlayingList(movies: [],),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString(), style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
                    );
                  }
              
                  return NowPlayingList(movies: snapshot.data!.results);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  'Popular',
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                ),
              ),
             
              FutureBuilder(
                future: popularMovies,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const MoviesHorizontalList(movies: []);
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString(),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
                    );
                  }
                  return  MoviesHorizontalList(movies: snapshot.data!.results);
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  'Upcoming',
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                ),
              ),
              FutureBuilder(
                future: upcomingMovies,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                         return const MoviesHorizontalList(movies: []); 
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString(),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
                    );
                  }
                  return  MoviesHorizontalList(movies: snapshot.data!.results);
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
