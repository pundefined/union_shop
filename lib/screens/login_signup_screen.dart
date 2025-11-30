import 'package:flutter/material.dart';
import 'package:union_shop/widgets/page_content.dart';

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
    final isMobile = MediaQuery.of(context).size.width < 600;

    return PageContent(
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20.0 : 32.0,
              vertical: 24.0,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ============================================================
                  // BRANDING SECTION
                  // ============================================================
                  _buildBrandingSection(),
                  const SizedBox(height: 40),

                  // ============================================================
                  // EMAIL/USERNAME INPUT FIELD
                  // ============================================================
                  _buildEmailField(),
                  const SizedBox(height: 20),

                  // ============================================================
                  // PASSWORD INPUT FIELD
                  // ============================================================
                  _buildPasswordField(),
                  const SizedBox(height: 16),

                  // ============================================================
                  // REMEMBER ME CHECKBOX (if login mode)
                  // ============================================================
                  if (_isLoginMode) _buildRememberMeCheckbox(),
                  if (_isLoginMode) const SizedBox(height: 8),

                  // ============================================================
                  // FORGOT PASSWORD LINK (if login mode)
                  // ============================================================
                  if (_isLoginMode) _buildForgotPasswordLink(),
                  if (_isLoginMode) const SizedBox(height: 16),

                  // ============================================================
                  // ACTION BUTTONS (Phase 4)
                  // ============================================================
                  if (_isLoginMode) _buildLoginButton() else _buildSignupButton(),
                  const SizedBox(height: 24),

                  // ============================================================
                  // MODE TOGGLE (Login/Signup Switch)
                  // ============================================================
                  _buildModeToggle(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================================
  // UI BUILDER METHODS
  // ============================================================================

  /// Builds the branding section at the top of the form
  Widget _buildBrandingSection() {
    return Column(
      children: [
        // App logo or title
        Text(
          'UNION SHOP',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        // Subtitle based on mode
        Text(
          _isLoginMode ? 'Log in to your account' : 'Create a new account',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// Builds the email/username input field
  Widget _buildEmailField() {
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Username or Email',
        hintText: 'Enter your username or email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.grey[300]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        prefixIcon: const Icon(Icons.email_outlined),
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        // State updates automatically due to TextField controller binding
      },
    );
  }

  /// Builds the password input field with visibility toggle
  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.grey[300]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        prefixIcon: const Icon(Icons.lock_outlined),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey[600],
          ),
          onPressed: _togglePasswordVisibility,
          tooltip: _isPasswordVisible ? 'Hide password' : 'Show password',
        ),
      ),
      onChanged: (value) {
        // State updates automatically due to TextField controller binding
      },
    );
  }

  /// Builds the "Remember me" checkbox (only shown in login mode)
  Widget _buildRememberMeCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _rememberMe,
          onChanged: (value) => _toggleRememberMe(value ?? false),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => _toggleRememberMe(!_rememberMe),
            child: Text(
              'Remember me',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the "Forgot password?" link (only shown in login mode)
  Widget _buildForgotPasswordLink() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // TODO: Implement password recovery flow
          debugPrint('Forgot password clicked');
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          minimumSize: const Size(48, 48),
        ),
        child: Text(
          'Forgot password?',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                decoration: TextDecoration.underline,
              ),
        ),
      ),
    );
  }

  /// Builds the mode toggle button (switches between login and signup)
  Widget _buildModeToggle() {
    return Center(
      child: Column(
        children: [
          Text(
            _isLoginMode
                ? "Don't have an account? "
                : 'Already have an account? ',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: _switchMode,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              minimumSize: const Size(48, 48),
            ),
            child: Text(
              _isLoginMode ? 'Sign up here' : 'Log in here',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the login button (shown in login mode)
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
        ),
        child: const Text(
          'LOG IN',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  /// Builds the signup button (shown in signup mode)
  Widget _buildSignupButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _handleSignup,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
        ),
        child: const Text(
          'SIGN UP',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
