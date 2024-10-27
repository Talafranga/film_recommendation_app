import 'package:flutter/material.dart';
import 'movie_service.dart';
import 'menu.dart';
import 'chatgpt.dart';

/// Displays a list of movies, filtered by category if a category ID is provided.
/// Includes navigation to a menu and ChatGPT screen for further options and assistance.
class MovieListScreen extends StatelessWidget {
  final String? categoryId;

  const MovieListScreen({Key? key, this.categoryId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MovieService movieService = MovieService();

    return Scaffold(
      drawer: MenuScreen(), // Side menu drawer
      body: Builder(
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.black, // Background color for the movie list
            ),
            child: Column(
              children: [
                // Top bar with menu and ChatGPT icons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Menu icon to open drawer
                      GestureDetector(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Image.asset(
                            'lib/images/menu_icon.png',
                            width: 55,
                            height: 55,
                          ),
                        ),
                      ),
                      // ChatGPT icon to open chat screen
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ChatGPTScreen()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Image.asset(
                            'lib/images/chatgpt_icon.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Display movies based on category ID
                Expanded(
                  child: FutureBuilder(
                    future: movieService.fetchMovies(categoryId ?? '28'), // Default category is 'Action'
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator()); // Loading indicator
                      } else if (snapshot.hasData) {
                        List<Movie> movies = snapshot.data!;
                        return GridView.builder(
                          padding: const EdgeInsets.all(16),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.6,
                          ),
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            final movie = movies[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Movie poster
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                      fit: BoxFit.cover,
                                      height: 150,
                                      width: double.infinity,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // Movie title
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      movie.title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  // Movie overview
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                      movie.overview,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        return const Center(child: Text('No movies found'));
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
