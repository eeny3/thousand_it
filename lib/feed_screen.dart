import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constants.dart';
import 'movie_class.dart';
import 'movie_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  ScrollController scrollController = ScrollController();

  int currentPage = 1; //variable to keep track of which page of API response to display
  List<Movie> movieList = []; //collection of all Movie instances in current screen

  Future<List<Movie>> getMovies(int page) async{ //method to get all the movies info in current page
    var jsonData;
    List<Movie> movies = [];

    String fileName = "userdata.json";
    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/" + fileName);//file which will cache the last API call

    if (file.existsSync() && currentPage == 1){
      print("Loading from cache");
      var jsonString = file.readAsStringSync();
      jsonData = jsonDecode(jsonString);
    }
    else{
      print("Loading from API");
      var data = await http.get('$kGetTrendingUrl$page');
      jsonData = jsonDecode(data.body);
      file.writeAsStringSync(jsonEncode(jsonData), flush: false, mode: FileMode.write);
    }

    for(var i = 0; i < 10; ++i){
      String name = jsonData["results"][i]["title"];
      String poster = jsonData["results"][i]["backdrop_path"];
      String releaseDate = jsonData["results"][i]["release_date"];
      double rating = jsonData["results"][i]["vote_average"];
      int id = jsonData["results"][i]["id"];
      String overview = jsonData["results"][i]["overview"];
      String imagePath = jsonData["results"][i]["poster_path"];
      List<dynamic> genreIds = jsonData["results"][i]["genre_ids"];
      List<String> genres = [];
      for(var id in genreIds){
        for(var key in kGenres.keys){
          if(id == key){
            genres.add(kGenres[key]);
          }
        }
      }
      Movie movie = Movie(name, poster, releaseDate, rating, id, overview, imagePath, genres);
      movies.add(movie);
    }

    setState(() {
      movieList.addAll(movies); //update our collection with new portion of movies
    });
    return movies;
  }

  bool reachedTheEnd(){
    if(scrollController.position.pixels
        == scrollController.position.maxScrollExtent)
      return true;
    else
      return false;
  }

  Future<void> refresh() async{
    setState(() {
      currentPage = 1;
      movieList = [];
    });

    String fileName = "userdata.json";
    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/" + fileName);

    file.delete();//deleting file since we want fresh information on refresh

    await getMovies(currentPage);
  }

  @override
  void initState() {
    super.initState();

    getMovies(currentPage);//get first 10 movies

    scrollController.addListener(() {
      if(reachedTheEnd() && (currentPage < kMaxPages)){
        setState(() {
          currentPage = currentPage + 1;
        });
        getMovies(currentPage);//get some more movies from the next page if got to the end of first list
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Trending Now"),
        backgroundColor: kAppBarColor,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20),
          child: RefreshIndicator(
                  onRefresh: refresh,
                  child: ListView.builder(
                  itemCount: movieList.length,
                  controller: scrollController,
                  itemBuilder: (context, index){
                    return MovieWidget(movieList[index]);
                  }
              ),
          ),
      ),
    );
  }
}

