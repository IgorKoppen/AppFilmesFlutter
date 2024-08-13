import 'package:flutter/material.dart';
import 'package:movie_app/pages/home/home_page.dart';
import 'package:movie_app/pages/search/search_page.dart';
import 'package:movie_app/pages/top_rated/top_rated_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentPage = 0;
  PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: const [HomePage(), SearchPage(), TopRatedPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        iconSize: 30.0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.trending_up), label: 'Top Rated'),
        ],
        onTap: (value) {
          setState(() {
            currentPage = value;
            pageController.animateToPage(value,
                duration: const Duration(milliseconds: 400),
                curve: Curves.ease);
          });
        },
      ),
    );
  }
}
