import 'package:flutter/material.dart';

import 'api_call.dart';
import 'helper_class.dart';

class MovieSearchScreen extends StatefulWidget {
  @override
  _MovieSearchScreenState createState() => _MovieSearchScreenState();
}

class _MovieSearchScreenState extends State<MovieSearchScreen> {
  final _searchController = TextEditingController();
  final _apiHelper = APIHelper();

  List<String> searchResults = [];

  void _showMovieDetails(Movie movie) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff333333),
                  Color(0xffdd1818),
                ],
              ),
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${movie.title}",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                Image.network(movie.poster, fit: BoxFit.cover),
                Text(
                  "Year: ${movie.year}",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  "Released: ${movie.released}",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  "Director: ${movie.director}",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  "Language: ${movie.language}",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  "Awards: ${movie.awards}",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  "IMDb Rating: ${movie.imdbRating}",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  "Type: ${movie.type}",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  "Box Office: ${movie.boxOffice}",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> searchMovies() async {
    final query = _searchController.text;
    final imdbIDs = await _apiHelper.searchMovies(query);
    setState(() {
      searchResults = imdbIDs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Search"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Search for a movie",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: searchMovies,
                  icon: Icon(Icons.search),
                ),
              ),
              onChanged: (value) => searchMovies(),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final imdbID = searchResults[index];
                return FutureBuilder<Movie?>(
                  future: _apiHelper.getMovieDetails(imdbID),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final movie = snapshot.data!;
                      return InkWell(
                        onTap: () {
                          _showMovieDetails(movie);
                        },
                        child: Container(
                          height: 500,
                          width: 100,
                          child: Image.network(movie.poster, fit: BoxFit.cover),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
