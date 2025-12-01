import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';

/// Provider that manages authentication state throughout the app.
///
/// Uses [ChangeNotifier] to notify listeners when auth state changes,
/// enabling reactive UI updates based on authentication status.
class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  StreamSubscription<User?>? _authSubscription;

  User? _user;
  bool _isLoading = false;
  String? _error;

  /// Creates an [AuthProvider] instance.
  ///
  /// Optionally accepts an [AuthService] instance for dependency injection.
  /// If not provided, creates a new [AuthService] instance.
  AuthProvider({AuthService? authService})
      : _authService = authService ?? AuthService() {
    _init();
  }

  /// Initializes the provider by listening to auth state changes.
  void _init() {
    _authSubscription =
        _authService.authStateChanges.listen(_onAuthStateChanged);
    // Set initial user state
    _user = _authService.currentUser;
  }

  /// Handles auth state changes from Firebase.
  void _onAuthStateChanged(User? user) {
    _user = user;
    notifyListeners();
  }

  // ============================================================================
  // GETTERS
  // ============================================================================

  /// Returns the currently authenticated user, or null if not signed in.
  User? get user => _user;

  /// Returns true if a user is currently authenticated.
  bool get isAuthenticated => _user != null;

  /// Returns true if an auth operation is in progress.
  bool get isLoading => _isLoading;

  /// Returns the current error message, or null if no error.
  String? get error => _error;

  /// Returns the user's email address, or null if not authenticated.
  String? get userEmail => _user?.email;

  // ============================================================================
  // AUTHENTICATION METHODS
  // ============================================================================

  /// Signs in a user with email and password.
  ///
  /// Sets [isLoading] to true during the operation and updates [error]
  /// if the operation fails.
  ///
  /// Returns true if sign in was successful, false otherwise.
  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _setError(e.code);
      _setLoading(false);
      return false;
    } catch (e) {
      _setError('unknown');
      _setLoading(false);
      return false;
    }
  }

  /// Creates a new user account with email and password.
  ///
  /// Sets [isLoading] to true during the operation and updates [error]
  /// if the operation fails.
  ///
  /// Returns true if sign up was successful, false otherwise.
  Future<bool> signUp({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      await _authService.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );
      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _setError(e.code);
      _setLoading(false);
      return false;
    } catch (e) {
      _setError('unknown');
      _setLoading(false);
      return false;
    }
  }

  /// Signs out the current user.
  ///
  /// Sets [isLoading] to true during the operation.
  Future<void> signOut() async {
    _setLoading(true);
    _clearError();

    try {
      await _authService.signOut();
    } catch (e) {
      _setError('sign-out-failed');
    } finally {
      _setLoading(false);
    }
  }

  /// Clears any existing error message.
  void clearError() {
    _clearError();
  }

  // ============================================================================
  // PRIVATE HELPER METHODS
  // ============================================================================

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String errorCode) {
    _error = errorCode;
    notifyListeners();
  }

  void _clearError() {
    if (_error != null) {
      _error = null;
      notifyListeners();
    }
  }

  // ============================================================================
  // DISPOSAL
  // ============================================================================

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}
