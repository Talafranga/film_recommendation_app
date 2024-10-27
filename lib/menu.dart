import 'package:flutter/material.dart';
import 'movie_list_screen.dart';
import 'sign_in_screen.dart';

/// This screen displays a menu with login and movie categories.
/// It allows users to navigate to the login screen or filter movies by category.
class MenuScreen extends StatelessWidget {
  MenuScreen({Key? key}) : super(key: key);

  // Categories map: Maps each category name to its corresponding ID for API requests.
  final Map<String, String> categories = {
    'Action': '28',
    'Adventure': '12',
    'Animation': '16',
    'Comedy': '35',
    'Crime': '80',
    'Documentary': '99',
    'Drama': '18',
    'Family': '10751',
    'Horror': '27',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Navigates back to the previous screen
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 20),
          
          // Login Button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()), // Opens the login screen
                );
              },
              child: const Text(
                'Log in',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF192020),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Categories Title
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Movie categories',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Category Buttons
          for (var category in categories.entries)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the menu screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieListScreen(categoryId: category.value), // Opens movies filtered by category
                    ),
                  );
                },
                child: Text(
                  category.key,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF192020),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
