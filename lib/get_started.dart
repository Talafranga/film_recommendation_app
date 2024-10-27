import 'package:flutter/material.dart';
import 'movie_list_screen.dart';

/// This screen welcomes users and allows them to get started
/// with a movie recommendation journey.
class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Background container setup with black overlay and background image
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage('lib/images/getstarted_background.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(1.0),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container for introductory text background
              Container(
                width: 718,
                height: 191,
                decoration: BoxDecoration(
                  color: const Color(0xFF0F1212).withOpacity(0.6), // Slightly transparent dark background
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'If you love movies',
                      style: TextStyle(
                        fontFamily: 'Kantumruy Pro',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'find your next favorite instantly!',
                      style: TextStyle(
                        fontFamily: 'Kantumruy Pro',
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),

              // "Get Started" button to navigate to the MovieListScreen
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MovieListScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF192020).withOpacity(0.9),
                  fixedSize: const Size(283, 70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(34),
                  ),
                  elevation: 10,
                  shadowColor: Colors.black.withOpacity(0.8),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    fontFamily: 'Kantumruy Pro',
                    fontSize: 18,
                    color: Colors.white,
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
