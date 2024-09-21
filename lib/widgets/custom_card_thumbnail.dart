import 'package:flutter/material.dart';
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/pages/movie_details/details_sheet.dart';

class CustomCardThumbnail extends StatelessWidget {
  final String imageAsset;
  final int movieId;
  const CustomCardThumbnail({super.key,required this.movieId, required this.imageAsset});
 
 void showDetailsSheet(BuildContext context, int movieId) {
    showModalBottomSheet(
      context: context,
       isScrollControlled: true,
      builder: (context) => DetailsSheet(movieId: movieId),
    );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => showDetailsSheet(context, movieId),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
          image: DecorationImage(
            image: NetworkImage(
              '$imageUrl$imageAsset',
            ),
            fit: BoxFit.cover,
            onError: (exception, stackTrace) =>
                const AssetImage("images/netflix.png"),
          ),
        ),
        margin: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 30),
      ),
    );
  }
}
