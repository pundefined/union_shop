import 'package:flutter/material.dart';

/// LoginSignupScreen provides a unified interface for user authentication.
/// Users can toggle between login and signup modes, with form state management
/// for email/username, password, and additional preferences.
class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({super.key});

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  // ============================================================================
  // TEXT EDITING CONTROLLERS
  // ============================================================================

  /// Controller for email/username input field
  late TextEditingController _emailController;

  /// Controller for password input field
  late TextEditingController _passwordController;

  // ============================================================================
  // STATE VARIABLES
  // ============================================================================

  /// Tracks whether the form is in login mode (true) or signup mode (false)
  bool _isLoginMode = true;

  /// Tracks whether the password is visible or obscured
  bool _isPasswordVisible = false;

  /// Tracks whether the "Remember me" checkbox is checked
  bool _rememberMe = false;

  // ============================================================================
  // LIFECYCLE METHODS
  // ============================================================================

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // Clean up controllers to prevent memory leaks
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ============================================================================
  // EVENT HANDLERS
  // ============================================================================

  /// Toggles the visibility of the password field
  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  /// Toggles the "Remember me" checkbox state
  void _toggleRememberMe(bool value) {
    setState(() {
      _rememberMe = value;
    });
  }

  /// Switches between login and signup modes, clearing form fields
  void _switchMode() {
    setState(() {
      _isLoginMode = !_isLoginMode;
      _emailController.clear();
      _passwordController.clear();
      _isPasswordVisible = false;
      _rememberMe = false;
    });
  }

  /// Placeholder handler for login action
  void _handleLogin() {
    // TODO: Implement actual login logic with backend integration
    final email = _emailController.text;
    // ignore: unused_local_variable
    final password = _passwordController.text;
    debugPrint('Login attempt: email=$email, rememberMe=$_rememberMe');
  }

  /// Placeholder handler for signup action
  void _handleSignup() {
    // TODO: Implement actual signup logic with backend integration
    final email = _emailController.text;
    // ignore: unused_local_variable
    final password = _passwordController.text;
    debugPrint('Signup attempt: email=$email');
  }

  // ============================================================================
  // BUILD METHOD
  // ============================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Placeholder for logo/branding (Phase 2)
                const SizedBox(height: 40),

                // Email/Username input field (Phase 2)
                const SizedBox(height: 32),

                // Password input field (Phase 2)
                const SizedBox(height: 32),

                // Remember me checkbox (Phase 3)
                const SizedBox(height: 16),

                // Forgot password link (Phase 3)
                const SizedBox(height: 32),

                // Login/Signup button (Phase 4)
                const SizedBox(height: 16),

                // Mode toggle (Phase 3)
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
