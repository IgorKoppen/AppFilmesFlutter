import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_datails.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/api_services.dart';
import 'package:movie_app/widgets/custom_card_thumbnail.dart';
import 'package:movie_app/widgets/custom_card_thumbnail_placeholder.dart';

class NowPlayingList extends StatefulWidget {
  final List<Movie> movies;
  const NowPlayingList({super.key, required this.movies});

  @override
  State<NowPlayingList> createState() => _NowPlayingListState();
}

class _NowPlayingListState extends State<NowPlayingList> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  final indicatorLimit = 6;
  int currentPage = 0;
 

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: PageView.builder(
            onPageChanged: (int page) {
              setState(() {
                currentPage = page;
              });
            },

            controller: _pageController,
            itemCount: widget.movies.isEmpty ? 0 : indicatorLimit,
            itemBuilder: (context, index) {
              if (widget.movies.isEmpty) {
                return const CustomCardThumbnailPlaceholder();
              }
              return CustomCardThumbnail(
                imageAsset: widget.movies[index].posterPath,
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildPageIndicators(),
        ),
      ],
    );
  }

  List<Widget> _buildPageIndicators() {
    List<Widget> indicator = [];
    for (var i = 0; i < indicatorLimit; i++) {
      indicator.add(_buildIndicator(i == currentPage));
    }
    return indicator;
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      height: 8.0,
      width: 8.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white24,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
