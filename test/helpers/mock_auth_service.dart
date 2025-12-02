import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:union_shop/services/auth_service.dart';

/// Test-only subclass to create FirebaseAuthException instances.
/// The base class constructor is @protected, so we extend it for testing.
class TestFirebaseAuthException extends FirebaseAuthException {
  TestFirebaseAuthException({required super.code, super.message});
}

/// Mock implementation of AuthService for testing purposes.
/// Does not depend on Firebase Auth.
class MockAuthService implements AuthService {
  final StreamController<User?> _authStateController =
      StreamController<User?>.broadcast();

  User? _currentUser;
  bool shouldThrowOnSignIn = false;
  bool shouldThrowOnSignUp = false;
  bool shouldThrowOnSignOut = false;
  String errorCodeToThrow = 'unknown';

  @override
  Stream<User?> get authStateChanges => _authStateController.stream;

  @override
  User? get currentUser => _currentUser;

  /// Simulates a successful sign in by setting the current user.
  void simulateSignIn(User user) {
    _currentUser = user;
    _authStateController.add(user);
  }

  /// Simulates a sign out by clearing the current user.
  void simulateSignOut() {
    _currentUser = null;
    _authStateController.add(null);
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (shouldThrowOnSignIn) {
      throw TestFirebaseAuthException(
        code: errorCodeToThrow,
        message: 'Mock error',
      );
    }
    // Return a mock successful result - we don't actually need the credential
    // since AuthProvider doesn't use it directly
    return MockUserCredential();
  }

  @override
  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (shouldThrowOnSignUp) {
      throw TestFirebaseAuthException(
        code: errorCodeToThrow,
        message: 'Mock error',
      );
    }
    return MockUserCredential();
  }

  @override
  Future<void> signOut() async {
    if (shouldThrowOnSignOut) {
      throw Exception('Sign out failed');
    }
    simulateSignOut();
  }

  void dispose() {
    _authStateController.close();
  }
}

/// Mock UserCredential for testing.
class MockUserCredential implements UserCredential {
  @override
  AdditionalUserInfo? get additionalUserInfo => null;

  @override
  AuthCredential? get credential => null;

  @override
  User? get user => null;
}
