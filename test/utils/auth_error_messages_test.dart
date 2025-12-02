import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/utils/auth_error_messages.dart';

void main() {
  group('getAuthErrorMessage', () {
    group('Sign In Errors', () {
      test('returns message for invalid-credential', () {
        expect(
          getAuthErrorMessage('invalid-credential'),
          equals(
              'Invalid email or password. Please check your credentials and try again.'),
        );
      });

      test('returns message for user-not-found', () {
        expect(
          getAuthErrorMessage('user-not-found'),
          equals('No account found with this email. Please sign up first.'),
        );
      });

      test('returns message for wrong-password', () {
        expect(
          getAuthErrorMessage('wrong-password'),
          equals('Incorrect password. Please try again.'),
        );
      });

      test('returns message for user-disabled', () {
        expect(
          getAuthErrorMessage('user-disabled'),
          equals('This account has been disabled.'),
        );
      });

      test('returns message for too-many-requests', () {
        expect(
          getAuthErrorMessage('too-many-requests'),
          equals('Too many failed attempts. Please try again later.'),
        );
      });
    });

    group('Sign Up Errors', () {
      test('returns message for email-already-in-use', () {
        expect(
          getAuthErrorMessage('email-already-in-use'),
          equals(
              'An account already exists with this email. Please sign in instead.'),
        );
      });

      test('returns message for invalid-email', () {
        expect(
          getAuthErrorMessage('invalid-email'),
          equals('Please enter a valid email address.'),
        );
      });

      test('returns message for weak-password', () {
        expect(
          getAuthErrorMessage('weak-password'),
          equals('Password is too weak. Please use at least 6 characters.'),
        );
      });

      test('returns message for operation-not-allowed', () {
        expect(
          getAuthErrorMessage('operation-not-allowed'),
          equals(
              'Email/password sign up is not enabled. Please contact support.'),
        );
      });
    });

    group('Sign Out Errors', () {
      test('returns message for sign-out-failed', () {
        expect(
          getAuthErrorMessage('sign-out-failed'),
          equals('Failed to sign out. Please try again.'),
        );
      });
    });

    group('Network Errors', () {
      test('returns message for network-request-failed', () {
        expect(
          getAuthErrorMessage('network-request-failed'),
          equals('Network error. Please check your connection and try again.'),
        );
      });
    });

    group('Generic Errors', () {
      test('returns message for unknown error code', () {
        expect(
          getAuthErrorMessage('unknown'),
          equals('An unexpected error occurred. Please try again.'),
        );
      });

      test('returns default message for unrecognized error code', () {
        expect(
          getAuthErrorMessage('some-random-error'),
          equals('An unexpected error occurred. Please try again.'),
        );
      });

      test('returns default message for empty string', () {
        expect(
          getAuthErrorMessage(''),
          equals('An unexpected error occurred. Please try again.'),
        );
      });
    });
  });
}
