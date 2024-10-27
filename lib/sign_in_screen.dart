import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_service.dart';
import 'sign_up_screen.dart';

/// A screen for user login with email and password.
class SignInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Log in', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme:
            const IconThemeData(color: Colors.white), // Sets back icon to white
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Email TextField
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),

            /// Password TextField
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              obscureText: true,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 24),

            /// Log In Button
            ElevatedButton(
              onPressed: () async {
                try {
                  User? user = await AuthService().signInWithEmail(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );

                  // Successful login navigation and feedback
                  if (user != null) {
                    Navigator.pushReplacementNamed(context, '/home');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Login Successful')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Login Failed')),
                    );
                  }
                } catch (e) {
                  print('Sign in error: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('An error occurred. Please try again.')),
                  );
                }
              },
              child: const Text(
                'Log in',
                style:
                    TextStyle(color: Colors.white), // Set text color to white
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF192020),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
            ),
            const SizedBox(height: 20),

            /// Navigation to Sign Up Screen
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
              child: const Text(
                'Create an Account',
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
