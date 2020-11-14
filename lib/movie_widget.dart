import 'package:flutter/material.dart';
import 'movie_class.dart';
import 'constants.dart';
import 'info_screen.dart';

class MovieWidget extends StatelessWidget {
  final Movie movie;
  MovieWidget(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        height: MediaQuery.of(context).orientation == Orientation.portrait ? null : 300,//constraint the height if landscape orientation so widget would fit the screen
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InfoScreen(movie)),
            );
          },
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child:
            Stack(
              children: [
              Container( //1:1 container to display movie
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  image: DecorationImage(
                    image: NetworkImage(
                      "$kImagesUrl${movie.poster}",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container( //50% transparent container to give the image blackout effect
                  color: Color(0x800E212F),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Center(
                      child: Column( //column of texts: movie title, premiere date
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            movie.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            movie.releaseDate,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
                Container(//container to display vote_average
                  margin: EdgeInsets.all(10),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      )
                  ),
                  child: Center(
                    child: Text(
                      "${movie.rating}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}