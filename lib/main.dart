import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'get_started.dart';
import 'movie_list_screen.dart';

/// Main entry point for the application.
/// Initializes Firebase and starts the app with the [FilmRecommendationApp].
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Initializes Firebase with platform-specific options
  );
  runApp(const FilmRecommendationApp());
}

/// Main application widget which sets up theme and navigation routes.
class FilmRecommendationApp extends StatelessWidget {
  const FilmRecommendationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Film Recommendation App', // App title shown in device's task manager
      theme: ThemeData(
        primarySwatch: Colors.blue, // Sets the primary theme color
      ),
      initialRoute: '/', // Sets the initial route of the app
      routes: {
        '/': (context) => const GetStartedScreen(), // Route for the Get Started screen
        '/home': (context) => const MovieListScreen(), // Route for the Movie List screen
      },
    );
  }
}
