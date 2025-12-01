import 'package:firebase_auth/firebase_auth.dart';

/// Service class that wraps Firebase Auth functionality.
///
/// Provides methods for email/password authentication including
/// sign in, sign up, and sign out operations.
class AuthService {
  /// The Firebase Auth instance used for authentication operations.
  final FirebaseAuth _firebaseAuth;

  /// Creates an [AuthService] instance.
  ///
  /// Optionally accepts a [FirebaseAuth] instance for testing purposes.
  /// If not provided, uses the default [FirebaseAuth.instance].
  AuthService({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  /// Stream of authentication state changes.
  ///
  /// Emits the current [User] when the auth state changes,
  /// or null if the user is signed out.
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Returns the currently signed-in user, or null if not authenticated.
  User? get currentUser => _firebaseAuth.currentUser;

  /// Signs in a user with email and password.
  ///
  /// Returns [UserCredential] on success.
  /// Throws [FirebaseAuthException] on failure with error codes such as:
  /// - `invalid-credential`: Invalid email or password.
  /// - `user-not-found`: No user found with this email.
  /// - `wrong-password`: Incorrect password.
  /// - `user-disabled`: User account has been disabled.
  /// - `too-many-requests`: Too many failed attempts, try again later.
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Creates a new user account with email and password.
  ///
  /// Returns [UserCredential] on success.
  /// Throws [FirebaseAuthException] on failure with error codes such as:
  /// - `email-already-in-use`: An account already exists with this email.
  /// - `invalid-email`: The email address is not valid.
  /// - `weak-password`: The password is too weak (min 6 characters).
  /// - `operation-not-allowed`: Email/password accounts are not enabled.
  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Signs out the current user.
  ///
  /// Clears the authentication state and removes any cached credentials.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
