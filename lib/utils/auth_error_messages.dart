/// Maps Firebase Auth error codes to user-friendly error messages.
///
/// Provides clear, actionable messages for common authentication errors
/// that users may encounter during sign in, sign up, or sign out operations.
String getAuthErrorMessage(String errorCode) {
  switch (errorCode) {
    // Sign In Errors
    case 'invalid-credential':
      return 'Invalid email or password. Please check your credentials and try again.';
    case 'user-not-found':
      return 'No account found with this email. Please sign up first.';
    case 'wrong-password':
      return 'Incorrect password. Please try again.';
    case 'user-disabled':
      return 'This account has been disabled.';
    case 'too-many-requests':
      return 'Too many failed attempts. Please try again later.';

    // Sign Up Errors
    case 'email-already-in-use':
      return 'An account already exists with this email. Please sign in instead.';
    case 'invalid-email':
      return 'Please enter a valid email address.';
    case 'weak-password':
      return 'Password is too weak. Please use at least 6 characters.';
    case 'operation-not-allowed':
      return 'Email/password sign up is not enabled. Please contact support.';

    // Sign Out Errors
    case 'sign-out-failed':
      return 'Failed to sign out. Please try again.';

    // Network Errors
    case 'network-request-failed':
      return 'Network error. Please check your connection and try again.';

    // Generic Errors
    case 'unknown':
    default:
      return 'An unexpected error occurred. Please try again.';
  }
}
