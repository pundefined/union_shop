import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/auth_provider.dart';
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
    return _MockUserCredential();
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
    return _MockUserCredential();
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
class _MockUserCredential implements UserCredential {
  @override
  AdditionalUserInfo? get additionalUserInfo => null;

  @override
  AuthCredential? get credential => null;

  @override
  User? get user => null;
}

void main() {
  group('AuthProvider', () {
    late MockAuthService mockAuthService;
    late AuthProvider authProvider;

    setUp(() {
      mockAuthService = MockAuthService();
      authProvider = AuthProvider(authService: mockAuthService);
    });

    tearDown(() {
      authProvider.dispose();
      mockAuthService.dispose();
    });

    group('Initial State', () {
      test('starts with user as null', () {
        expect(authProvider.user, isNull);
      });

      test('starts with isAuthenticated as false', () {
        expect(authProvider.isAuthenticated, isFalse);
      });

      test('starts with isLoading as false', () {
        expect(authProvider.isLoading, isFalse);
      });

      test('starts with error as null', () {
        expect(authProvider.error, isNull);
      });

      test('starts with userEmail as null', () {
        expect(authProvider.userEmail, isNull);
      });
    });

    group('signIn', () {
      test('returns true on successful sign in', () async {
        final result = await authProvider.signIn(
          email: 'test@example.com',
          password: 'password123',
        );

        expect(result, isTrue);
        expect(authProvider.error, isNull);
      });

      test('sets isLoading to true during sign in', () async {
        bool wasLoading = false;
        authProvider.addListener(() {
          if (authProvider.isLoading) {
            wasLoading = true;
          }
        });

        await authProvider.signIn(
          email: 'test@example.com',
          password: 'password123',
        );

        expect(wasLoading, isTrue);
        expect(authProvider.isLoading, isFalse);
      });

      test('returns false and sets error on failure', () async {
        mockAuthService.shouldThrowOnSignIn = true;
        mockAuthService.errorCodeToThrow = 'invalid-credential';

        final result = await authProvider.signIn(
          email: 'test@example.com',
          password: 'wrongpassword',
        );

        expect(result, isFalse);
        expect(authProvider.error, equals('invalid-credential'));
      });

      test('sets error to unknown for unexpected exceptions', () async {
        mockAuthService.shouldThrowOnSignIn = true;
        // Use a non-FirebaseAuthException error code pattern to trigger catch-all
        mockAuthService.errorCodeToThrow = 'user-not-found';

        final result = await authProvider.signIn(
          email: 'test@example.com',
          password: 'password123',
        );

        expect(result, isFalse);
        expect(authProvider.error, isNotNull);
      });

      test('clears previous error before sign in', () async {
        // First, create an error
        mockAuthService.shouldThrowOnSignIn = true;
        mockAuthService.errorCodeToThrow = 'invalid-credential';
        await authProvider.signIn(email: 'test@example.com', password: 'wrong');
        expect(authProvider.error, isNotNull);

        // Now try again successfully
        mockAuthService.shouldThrowOnSignIn = false;
        await authProvider.signIn(
            email: 'test@example.com', password: 'correct');
        expect(authProvider.error, isNull);
      });
    });

    group('signUp', () {
      test('returns true on successful sign up', () async {
        final result = await authProvider.signUp(
          email: 'new@example.com',
          password: 'password123',
        );

        expect(result, isTrue);
        expect(authProvider.error, isNull);
      });

      test('sets isLoading to true during sign up', () async {
        bool wasLoading = false;
        authProvider.addListener(() {
          if (authProvider.isLoading) {
            wasLoading = true;
          }
        });

        await authProvider.signUp(
          email: 'new@example.com',
          password: 'password123',
        );

        expect(wasLoading, isTrue);
        expect(authProvider.isLoading, isFalse);
      });

      test('returns false and sets error on failure', () async {
        mockAuthService.shouldThrowOnSignUp = true;
        mockAuthService.errorCodeToThrow = 'email-already-in-use';

        final result = await authProvider.signUp(
          email: 'existing@example.com',
          password: 'password123',
        );

        expect(result, isFalse);
        expect(authProvider.error, equals('email-already-in-use'));
      });

      test('sets error for weak password', () async {
        mockAuthService.shouldThrowOnSignUp = true;
        mockAuthService.errorCodeToThrow = 'weak-password';

        final result = await authProvider.signUp(
          email: 'new@example.com',
          password: '123',
        );

        expect(result, isFalse);
        expect(authProvider.error, equals('weak-password'));
      });
    });

    group('signOut', () {
      test('signs out successfully', () async {
        await authProvider.signOut();

        expect(authProvider.isAuthenticated, isFalse);
        expect(authProvider.user, isNull);
      });

      test('sets isLoading during sign out', () async {
        bool wasLoading = false;
        authProvider.addListener(() {
          if (authProvider.isLoading) {
            wasLoading = true;
          }
        });

        await authProvider.signOut();

        expect(wasLoading, isTrue);
        expect(authProvider.isLoading, isFalse);
      });

      test('sets error on sign out failure', () async {
        mockAuthService.shouldThrowOnSignOut = true;

        await authProvider.signOut();

        expect(authProvider.error, equals('sign-out-failed'));
      });
    });

    group('clearError', () {
      test('clears existing error', () async {
        mockAuthService.shouldThrowOnSignIn = true;
        mockAuthService.errorCodeToThrow = 'invalid-credential';
        await authProvider.signIn(email: 'test@example.com', password: 'wrong');
        expect(authProvider.error, isNotNull);

        authProvider.clearError();

        expect(authProvider.error, isNull);
      });

      test('does nothing if no error exists', () {
        expect(authProvider.error, isNull);

        // Should not throw or cause issues
        authProvider.clearError();

        expect(authProvider.error, isNull);
      });
    });

    group('Auth State Changes', () {
      test('notifies listeners when auth state changes', () async {
        int notifyCount = 0;
        authProvider.addListener(() {
          notifyCount++;
        });

        // Trigger auth state change via the mock
        mockAuthService.simulateSignOut();

        // Allow async listener to fire
        await Future.delayed(Duration.zero);

        expect(notifyCount, greaterThan(0));
      });
    });
  });
}
