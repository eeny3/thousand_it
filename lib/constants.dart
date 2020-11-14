import 'package:flutter/material.dart';

const String kApiKey = '53574f2b23e7e9523f57819409f55a2b';
const int kMaxPages = 1000;
const String kGetTrendingUrl = 'https://api.themoviedb.org/3/trending/movie/day?api_key=$kApiKey&page=';
const String kImagesUrl = 'https://image.tmdb.org/t/p/w500';
const Color kMainColor = Color(0xFF0E212F);
const Color kAppBarColor = Color(0xFF253B49);
const Map<int, String> kGenres = {
  28    : "Action",
  12    : "Adventure",
  16    : "Animation",
  35    : "Comedy",
  80    : "Crime",
  99    : "Documentary",
  18    : "Drama",
  10751 : "Family",
  14    : "Fantasy",
  36    : "History",
  27    : "Horror",
  10402 : "Music",
  9648  : "Mystery",
  10749 : "Romance",
  878   : "Sci-Fi",
  10770 : "Tv Movie",
  53    : "Thriller",
  10752 : "War",
  37    : "Western",
};