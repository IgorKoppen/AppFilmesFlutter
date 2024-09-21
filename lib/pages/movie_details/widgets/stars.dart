import 'package:flutter/material.dart';

class StarsBuild extends StatelessWidget {
  final double rating;
  const StarsBuild({super.key, required this.rating});

 Widget buildStarRating(double rating) {
    int fullStars = rating ~/ 1;
    return Row(
      children: List.generate(10, (index) {
        if (index < fullStars) {
          return const Icon(Icons.star, color: Colors.yellow, size: 20);
        } else {
          return const Icon(Icons.star_border, color: Colors.yellow, size: 20);
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildStarRating(rating);
  }
}