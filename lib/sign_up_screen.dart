import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_service.dart';

/// A screen for user registration with email and password.
class SignUpScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Create an Account', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white), // Sets back icon color to white
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

            /// Sign Up Button
            ElevatedButton(
              onPressed: () async {
                try {
                  // Registers the user with provided email and password
                  User? user = await AuthService().registerWithEmail(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );

                  // Navigates to home and shows success message if registration is successful
                  if (user != null) {
                    Navigator.pushReplacementNamed(context, '/home');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Account Created Successfully')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Registration Failed')),
                    );
                  }
                } on FirebaseAuthException catch (e) {
                  print('Registration error: ${e.code} - ${e.message}');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.message ?? 'Registration error')),
                  );
                } catch (e) {
                  print('General error: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('An error occurred. Please try again.')),
                  );
                }
              },
              child: const Text('Sign Up'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF192020),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
