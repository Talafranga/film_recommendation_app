import 'dart:convert';
import 'package:http/http.dart' as http;

/// MovieService class handles fetching movies from The Movie Database (TMDb) API.
class MovieService {
  final String apiKey = 'your_movie_api_key';
  final String apiReadAccessToken = 'eyJhbGciO...';

  /// Fetches movies based on a given genre.
  /// [genre] parameter determines the genre ID for filtering movies.
  /// Returns a List of Movie objects if successful, throws an Exception otherwise.
  Future<List<Movie>> fetchMovies(String genre) async {
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&with_genres=$genre'),
      headers: {
        'Authorization': 'Bearer $apiReadAccessToken',
        'Content-Type': 'application/json;charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      // Parse the JSON response and map it to a list of Movie objects
      List movies = jsonDecode(response.body)['results'];
      return movies.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies'); // Throw an error if the API call fails
    }
  }
}

/// Movie class represents a single movie, containing title, overview, and poster path.
class Movie {
  final String title;
  final String overview;
  final String posterPath;

  Movie({
    required this.title,
    required this.overview,
    required this.posterPath,
  });

  /// Factory method to create a Movie object from a JSON map.
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
    );
  }
}
