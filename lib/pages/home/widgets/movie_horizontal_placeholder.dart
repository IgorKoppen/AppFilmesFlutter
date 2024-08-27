import 'package:flutter/material.dart';

class MovieHorizontalPlaceholder extends StatelessWidget {
  const MovieHorizontalPlaceholder({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          width: 140,
          foregroundDecoration: BoxDecoration(
             borderRadius: BorderRadius.circular(18),
             shape: BoxShape.rectangle,
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(1),
                Colors.grey.withOpacity(0.6),
              ],
            ),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          ),
      ],
    );
  }
}
