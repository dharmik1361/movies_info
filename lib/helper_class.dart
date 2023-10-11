import 'package:http/http.dart' as http;
import 'dart:convert';

import 'api_call.dart';

class APIHelper {
  static final APIHelper _instance = APIHelper._internal();

  factory APIHelper() {
    return _instance;
  }

  APIHelper._internal();

  final String apiKey = '93861f17'; // Replace with your actual API key

  Future<List<String>> searchMovies(String query) async {
    final searchUrl = 'http://www.omdbapi.com/?s=$query&apikey=$apiKey';

    final response = await http.get(Uri.parse(searchUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['Response'] == 'True') {
        final searchResults = data['Search'];
        return List<String>.from(
          searchResults.map((json) => json['imdbID'] as String),
        );
      }
    }
    return <String>[];
  }

  Future<Movie?> getMovieDetails(String imdbID) async {
    final movieUrl = 'http://www.omdbapi.com/?i=$imdbID&apikey=$apiKey';

    final response = await http.get(Uri.parse(movieUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['Response'] == 'True') {
        return Movie.fromJson(data);
      }
    }
    return null;
  }
}
