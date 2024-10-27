import 'package:firebase_auth/firebase_auth.dart';

/// Service to handle Firebase Authentication for sign-in, sign-up, and sign-out operations.
class AuthService {
  // FirebaseAuth instance to interact with Firebase Authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Signs in the user with email and password.
  /// 
  /// Returns the [User] object on success, or `null` if an error occurs.
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      // Attempt to sign in the user with email and password
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      // Log error if sign-in fails
      print('Sign in error: ${e.toString()}');
      return null;
    }
  }

  /// Registers a new user with email and password.
  ///
  /// Returns the [User] object on success, or `null` if an error occurs.
  Future<User?> registerWithEmail(String email, String password) async {
    try {
      // Attempt to create a new user with email and password
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      // Log error if registration fails
      print('Registration error: ${e.toString()}');
      return null;
    }
  }

  /// Signs out the currently authenticated user.
  ///
  /// Returns a [Future] that completes when the sign-out is done.
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
