class Movie{
  final String name;
  final String poster;
  final String releaseDate;
  final double rating;
  final int movieId;
  final String overview;
  final String imagePath;
  final List<String> genres;
  Movie(this.name, this.poster, this.releaseDate, this.rating, this.movieId,
      this.overview, this.imagePath, this.genres);
}