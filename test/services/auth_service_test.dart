import 'package:flutter_test/flutter_test.dart';

import '../helpers/mock_auth_service.dart';

void main() {
  group('MockAuthService Tests', () {
    late MockAuthService mockAuthService;

    setUp(() {
      mockAuthService = MockAuthService();
    });

    tearDown(() {
      mockAuthService.dispose();
    });

    group('signInWithEmailAndPassword', () {
      test('returns UserCredential on success', () async {
        final result = await mockAuthService.signInWithEmailAndPassword(
          email: 'test@example.com',
          password: 'password123',
        );

        expect(result, isA<MockUserCredential>());
      });

      test('throws exception when shouldThrowOnSignIn is true', () async {
        mockAuthService.shouldThrowOnSignIn = true;
        mockAuthService.errorCodeToThrow = 'invalid-credential';

        expect(
          () => mockAuthService.signInWithEmailAndPassword(
            email: 'test@example.com',
            password: 'wrong',
          ),
          throwsA(isA<TestFirebaseAuthException>()),
        );
      });

      test('throws with correct error code', () async {
        mockAuthService.shouldThrowOnSignIn = true;
        mockAuthService.errorCodeToThrow = 'user-not-found';

        try {
          await mockAuthService.signInWithEmailAndPassword(
            email: 'test@example.com',
            password: 'password',
          );
          fail('Expected exception');
        } on TestFirebaseAuthException catch (e) {
          expect(e.code, 'user-not-found');
        }
      });
    });

    group('signUpWithEmailAndPassword', () {
      test('returns UserCredential on success', () async {
        final result = await mockAuthService.signUpWithEmailAndPassword(
          email: 'new@example.com',
          password: 'password123',
        );

        expect(result, isA<MockUserCredential>());
      });

      test('throws exception when shouldThrowOnSignUp is true', () async {
        mockAuthService.shouldThrowOnSignUp = true;
        mockAuthService.errorCodeToThrow = 'email-already-in-use';

        expect(
          () => mockAuthService.signUpWithEmailAndPassword(
            email: 'existing@example.com',
            password: 'password123',
          ),
          throwsA(isA<TestFirebaseAuthException>()),
        );
      });

      test('throws with correct error code', () async {
        mockAuthService.shouldThrowOnSignUp = true;
        mockAuthService.errorCodeToThrow = 'weak-password';

        try {
          await mockAuthService.signUpWithEmailAndPassword(
            email: 'test@example.com',
            password: '123',
          );
          fail('Expected exception');
        } on TestFirebaseAuthException catch (e) {
          expect(e.code, 'weak-password');
        }
      });
    });

    group('signOut', () {
      test('clears current user via simulateSignOut', () async {
        // signOut calls simulateSignOut internally
        await mockAuthService.signOut();
        expect(mockAuthService.currentUser, isNull);
      });

      test('throws exception when shouldThrowOnSignOut is true', () async {
        mockAuthService.shouldThrowOnSignOut = true;

        expect(
          () => mockAuthService.signOut(),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('authStateChanges', () {
      test('emits null when simulateSignOut is called', () async {
        expectLater(
          mockAuthService.authStateChanges,
          emits(isNull),
        );

        mockAuthService.simulateSignOut();
      });

      test('stream is broadcast', () {
        // Can listen multiple times without error
        mockAuthService.authStateChanges.listen((_) {});
        mockAuthService.authStateChanges.listen((_) {});
        // No exception means it's a broadcast stream
      });
    });

    group('currentUser', () {
      test('is null initially', () {
        expect(mockAuthService.currentUser, isNull);
      });

      test('returns null after simulateSignOut', () {
        mockAuthService.simulateSignOut();
        expect(mockAuthService.currentUser, isNull);
      });
    });

    group('error simulation', () {
      test('can simulate different error codes', () async {
        mockAuthService.shouldThrowOnSignIn = true;

        // Test invalid-credential
        mockAuthService.errorCodeToThrow = 'invalid-credential';
        try {
          await mockAuthService.signInWithEmailAndPassword(
            email: 'test@example.com',
            password: 'wrong',
          );
        } on TestFirebaseAuthException catch (e) {
          expect(e.code, 'invalid-credential');
        }

        // Test too-many-requests
        mockAuthService.errorCodeToThrow = 'too-many-requests';
        try {
          await mockAuthService.signInWithEmailAndPassword(
            email: 'test@example.com',
            password: 'wrong',
          );
        } on TestFirebaseAuthException catch (e) {
          expect(e.code, 'too-many-requests');
        }
      });
    });
  });

  group('MockUserCredential Tests', () {
    test('additionalUserInfo is null', () {
      final credential = MockUserCredential();
      expect(credential.additionalUserInfo, isNull);
    });

    test('credential is null', () {
      final credential = MockUserCredential();
      expect(credential.credential, isNull);
    });

    test('user is null', () {
      final credential = MockUserCredential();
      expect(credential.user, isNull);
    });
  });

  group('TestFirebaseAuthException Tests', () {
    test('stores code correctly', () {
      final exception = TestFirebaseAuthException(
        code: 'invalid-email',
        message: 'The email is invalid',
      );

      expect(exception.code, 'invalid-email');
    });

    test('stores message correctly', () {
      final exception = TestFirebaseAuthException(
        code: 'invalid-email',
        message: 'The email is invalid',
      );

      expect(exception.message, 'The email is invalid');
    });
  });
}
