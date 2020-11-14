import 'package:flutter/material.dart';
import 'constants.dart';
import 'movie_class.dart';

class InfoScreen extends StatelessWidget {
  final Movie movie;
  InfoScreen(this.movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 2,
                child: BackDropMovieImage(movie),
              ),
              Expanded(
                flex: 3,
                child: ListView(
                  padding: EdgeInsets.all(20),
                  children: [
                    MovieName(movie),
                    Row(
                      children: [
                        MoviePoster(movie),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 10, 5, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MovieRating(movie),
                              SizedBox(height: 15),
                              MovieReleaseDate(movie),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  GenreOne(movie),
                                  SizedBox(width: 5,),
                                  GenreTwo(movie),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Divider(
                      color: Colors.grey.shade800,
                      thickness: 2,
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Storyline',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    MovieOverview(movie),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          ),
          NavigateBackIcon(),
        ],
      ),
    );
  }
}

class MovieOverview extends StatelessWidget {
  final Movie movie;
  MovieOverview(this.movie);

  @override
  Widget build(BuildContext context) {
    return Text(
      movie.overview,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    );
  }
}

class GenreTwo extends StatelessWidget {
  final Movie movie;
  GenreTwo(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Text(
        movie.genres.length > 1 ? movie.genres[1] : "",
        style: TextStyle(
            color: Colors.white,
            fontSize: 12,),
      ),
      decoration: movie.genres.length > 1 ?
      BoxDecoration(
        borderRadius:
        BorderRadius.circular(8),
        border:
        Border.all(color: Colors.white),
      ) :
      BoxDecoration(),
    );
  }
}

class GenreOne extends StatelessWidget {
  final Movie movie;
  GenreOne(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Text(
        movie.genres.length > 0 ? movie.genres[0] : "no genres info",
        style: TextStyle(
            color: Colors.white,
            fontSize: 12,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.circular(8),
        border:
        Border.all(color: Colors.white),
      ),
    );
  }
}

class MovieReleaseDate extends StatelessWidget {
  final Movie movie;
  MovieReleaseDate(this.movie);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.date_range, color: Colors.white),
        SizedBox(width: 5),
        Text("${movie.releaseDate}",
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}

class MovieRating extends StatelessWidget {
  final Movie movie;
  MovieRating(this.movie);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.white),
        SizedBox(width: 5),
        Text("${movie.rating}",
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}

class MoviePoster extends StatelessWidget {
  final Movie movie;
  MoviePoster(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: 140,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            "$kImagesUrl${movie.imagePath}",
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class MovieName extends StatelessWidget {
  final Movie movie;
  MovieName(this.movie);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Text(
        "${movie.name}",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
    );
  }
}

class BackDropMovieImage extends StatelessWidget {
  final Movie movie;
  BackDropMovieImage(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            "$kImagesUrl${movie.poster}",
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class NavigateBackIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
      icon: Icon(Icons.arrow_back, color: Colors.white),
      onPressed: (){
        Navigator.pop(context);
      },
    );
  }
}
