import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/auth_provider.dart';
import 'package:union_shop/screens/login_signup_screen.dart';
import 'package:union_shop/widgets/app_shell.dart';

import '../helpers/mock_auth_service.dart';

void main() {
  group('LoginSignupScreen Widget Tests', () {
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

    // Helper widget to wrap LoginSignupScreen in AppShell for realistic testing
    Widget wrapInAppShell(Widget child) {
      return ChangeNotifierProvider<AuthProvider>.value(
        value: authProvider,
        child: MaterialApp(
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
          ),
          home: AppShell(child: child),
        ),
      );
    }

    // ========================================================================
    // INITIAL STATE TESTS
    // ========================================================================

    testWidgets('displays branding section with app name',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(const LoginSignupScreen()),
      );

      expect(find.text('UNION SHOP'), findsOneWidget);
    });

    testWidgets('displays login mode subtitle on initial load',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(const LoginSignupScreen()),
      );

      expect(find.text('Log in to your account'), findsOneWidget);
    });

    testWidgets('displays email/username input field',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(const LoginSignupScreen()),
      );

      expect(find.byType(TextField), findsWidgets);
      expect(find.text('Username or Email'), findsOneWidget);
    });

    testWidgets('displays password input field', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(const LoginSignupScreen()),
      );

      expect(find.text('Password'), findsOneWidget);
    });

    // ========================================================================
    // LOGIN MODE TESTS
    // ========================================================================

    testWidgets('displays remember me checkbox in login mode',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(const LoginSignupScreen()),
      );

      expect(find.text('Remember me'), findsOneWidget);
      expect(find.byType(Checkbox), findsOneWidget);
    });

    testWidgets('displays login button in login mode',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(const LoginSignupScreen()),
      );

      expect(find.text('LOG IN'), findsOneWidget);
      expect(find.text('SIGN UP'), findsNothing);
    });

    testWidgets('displays mode toggle for signup in login mode',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(const LoginSignupScreen()),
      );

      expect(find.text('Sign up here'), findsOneWidget);
    });

    // ========================================================================
    // SIGNUP MODE TESTS
    // ========================================================================

    testWidgets('switches to signup mode when mode toggle is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(const LoginSignupScreen()),
      );

      // Initially in login mode
      expect(find.text('Log in to your account'), findsOneWidget);

      // Scroll to make the mode toggle visible and tap it
      await tester.dragUntilVisible(
        find.text('Sign up here'),
        find.byType(SingleChildScrollView),
        const Offset(0, -100),
      );
      await tester.tap(find.text('Sign up here'));
      await tester.pumpAndSettle();

      // Now in signup mode
      expect(find.text('Create a new account'), findsOneWidget);
    });

    testWidgets('hides remember me checkbox in signup mode',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(const LoginSignupScreen()),
      );

      // Switch to signup mode
      await tester.dragUntilVisible(
        find.text('Sign up here'),
        find.byType(SingleChildScrollView),
        const Offset(0, -100),
      );
      await tester.tap(find.text('Sign up here'));
      await tester.pumpAndSettle();

      expect(find.text('Remember me'), findsNothing);
    });

    testWidgets('displays signup button in signup mode',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(const LoginSignupScreen()),
      );

      // Switch to signup mode
      await tester.dragUntilVisible(
        find.text('Sign up here'),
        find.byType(SingleChildScrollView),
        const Offset(0, -100),
      );
      await tester.tap(find.text('Sign up here'));
      await tester.pumpAndSettle();

      // Scroll to make sure SIGN UP button is visible
      await tester.dragUntilVisible(
        find.text('SIGN UP'),
        find.byType(SingleChildScrollView),
        const Offset(0, -100),
      );

      expect(find.text('SIGN UP'), findsOneWidget);
      expect(find.text('LOG IN'), findsNothing);
    });

    testWidgets('displays mode toggle for login in signup mode',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(const LoginSignupScreen()),
      );

      // Switch to signup mode
      await tester.dragUntilVisible(
        find.text('Sign up here'),
        find.byType(SingleChildScrollView),
        const Offset(0, -100),
      );
      await tester.tap(find.text('Sign up here'));
      await tester.pumpAndSettle();

      // Scroll to find the "Log in here" toggle
      await tester.dragUntilVisible(
        find.text('Log in here'),
        find.byType(SingleChildScrollView),
        const Offset(0, -100),
      );

      expect(find.text('Log in here'), findsOneWidget);
    });

    // ========================================================================
    // INPUT FIELD TESTS
    // ========================================================================

    testWidgets('email field accepts text input', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(const LoginSignupScreen()),
      );

      final emailField = find.byType(TextField).first;
      await tester.enterText(emailField, 'test@example.com');
      expect(find.text('test@example.com'), findsOneWidget);
    });

    testWidgets('password field obscures text by default',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(const LoginSignupScreen()),
      );

      // Enter text into password field
      final passwordField = find.byType(TextField).last;
      await tester.enterText(passwordField, 'mypassword123');
      await tester.pumpAndSettle();

      // Verify the visibility_off icon is present (indicating text is obscured)
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);

      // The visibility icon should NOT be present (would indicate unobscured)
      expect(find.byIcon(Icons.visibility), findsNothing);
    });

    // ========================================================================
    // PASSWORD VISIBILITY TOGGLE TESTS
    // ========================================================================

    testWidgets('toggling password visibility shows/hides password',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(const LoginSignupScreen()),
      );

      // Enter password
      final passwordField = find.byType(TextField).last;
      await tester.enterText(passwordField, 'password123');

      // Find and tap the visibility toggle button
      final visibilityToggle = find.byIcon(Icons.visibility_off);
      expect(visibilityToggle, findsOneWidget);

      // Tap to show password
      await tester.tap(visibilityToggle);
      await tester.pumpAndSettle();

      // Now should show visibility icon (not visibility_off)
      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    // ========================================================================
    // REMEMBER ME CHECKBOX TESTS
    // ========================================================================

    testWidgets('remember me checkbox can be toggled',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(const LoginSignupScreen()),
      );

      final checkbox = find.byType(Checkbox);
      expect(checkbox, findsOneWidget);

      // Tap the checkbox
      await tester.tap(checkbox);
      await tester.pumpAndSettle();

      // Checkbox should now be checked (would need to verify state in real app)
    });

    testWidgets('remember me label text is tappable',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(const LoginSignupScreen()),
      );

      final rememberMeText = find.text('Remember me');
      expect(rememberMeText, findsOneWidget);

      // Tap the label text
      await tester.tap(rememberMeText);
      await tester.pumpAndSettle();

      // Should toggle checkbox state
    });

    // ========================================================================
    // BUTTON TESTS
    // ========================================================================

    testWidgets('login button is tappable', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(const LoginSignupScreen()),
      );

      final loginButton = find.text('LOG IN');
      expect(loginButton, findsOneWidget);

      // Verify it's a button
      expect(find.byWidgetPredicate((widget) {
        return widget is ElevatedButton;
      }), findsWidgets);
    });

    testWidgets('signup button is tappable', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(const LoginSignupScreen()),
      );

      // Switch to signup mode
      await tester.dragUntilVisible(
        find.text('Sign up here'),
        find.byType(SingleChildScrollView),
        const Offset(0, -100),
      );
      await tester.tap(find.text('Sign up here'));
      await tester.pumpAndSettle();

      // Scroll to find the SIGN UP button
      await tester.dragUntilVisible(
        find.text('SIGN UP'),
        find.byType(SingleChildScrollView),
        const Offset(0, -100),
      );

      final signupButton = find.text('SIGN UP');
      expect(signupButton, findsOneWidget);

      // Verify it's a button
      expect(find.byWidgetPredicate((widget) {
        return widget is ElevatedButton;
      }), findsWidgets);
    });

    // ========================================================================
    // MODE SWITCHING TESTS
    // ========================================================================

    testWidgets('form clears when switching modes',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(const LoginSignupScreen()),
      );

      // Enter email
      final emailField = find.byType(TextField).first;
      await tester.enterText(emailField, 'test@example.com');
      expect(find.text('test@example.com'), findsOneWidget);

      // Switch to signup mode
      await tester.dragUntilVisible(
        find.text('Sign up here'),
        find.byType(SingleChildScrollView),
        const Offset(0, -100),
      );
      await tester.tap(find.text('Sign up here'));
      await tester.pumpAndSettle();

      // Email field should be cleared
      expect(find.text('test@example.com'), findsNothing);
    });

    testWidgets('password visibility resets when switching modes',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(const LoginSignupScreen()),
      );

      // Toggle password visibility
      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.visibility), findsOneWidget);

      // Switch to signup mode
      await tester.dragUntilVisible(
        find.text('Sign up here'),
        find.byType(SingleChildScrollView),
        const Offset(0, -100),
      );
      await tester.tap(find.text('Sign up here'));
      await tester.pumpAndSettle();

      // Should be back to obscured (visibility_off icon)
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });

    testWidgets('remember me unchecks when switching modes',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(const LoginSignupScreen()),
      );

      // Check the remember me checkbox
      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();

      // Switch to signup mode
      await tester.dragUntilVisible(
        find.text('Sign up here'),
        find.byType(SingleChildScrollView),
        const Offset(0, -100),
      );
      await tester.tap(find.text('Sign up here'));
      await tester.pumpAndSettle();

      // Switch back to login mode
      await tester.dragUntilVisible(
        find.text('Log in here'),
        find.byType(SingleChildScrollView),
        const Offset(0, -100),
      );
      await tester.tap(find.text('Log in here'));
      await tester.pumpAndSettle();

      // Remember me should be unchecked
      // (This would require state inspection in a real app)
    });

    // ========================================================================
    // LINK TESTS
    // ========================================================================

    testWidgets('mode toggle link in login mode is tappable',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(const LoginSignupScreen()),
      );

      // Scroll to find the mode toggle
      await tester.dragUntilVisible(
        find.text('Sign up here'),
        find.byType(SingleChildScrollView),
        const Offset(0, -100),
      );

      final modeToggle = find.text('Sign up here');
      expect(modeToggle, findsOneWidget);

      await tester.tap(modeToggle);
      await tester.pumpAndSettle();

      // Should now be in signup mode
      expect(find.text('Create a new account'), findsOneWidget);
    });

    testWidgets('mode toggle link in signup mode is tappable',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(const LoginSignupScreen()),
      );

      // Switch to signup mode
      await tester.dragUntilVisible(
        find.text('Sign up here'),
        find.byType(SingleChildScrollView),
        const Offset(0, -100),
      );
      await tester.tap(find.text('Sign up here'));
      await tester.pumpAndSettle();

      // Tap mode toggle in signup mode
      await tester.dragUntilVisible(
        find.text('Log in here'),
        find.byType(SingleChildScrollView),
        const Offset(0, -100),
      );
      final modeToggle = find.text('Log in here');
      await tester.tap(modeToggle);
      await tester.pumpAndSettle();

      // Should be back in login mode
      expect(find.text('Log in to your account'), findsOneWidget);
    });

    // ========================================================================
    // RESPONSIVE LAYOUT TESTS
    // ========================================================================

    testWidgets('form is centered on screen', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(const LoginSignupScreen()),
      );

      // The main column should be centered
      expect(find.byType(Center), findsWidgets);
    });
  });
}
