# User Authentication Feature Implementation

## Goal
Implement user authentication using Firebase Auth, enabling users to sign in, sign up, and sign out. Integrate authentication state throughout the app with appropriate UI updates in the navbar and protected routes.

## Feature Description

### Authentication Service
- **Firebase Auth integration**: Use `firebase_auth` package for authentication
- **Auth state management**: Create an AuthService/AuthProvider to manage authentication state
- **Supported auth methods**: Email/password authentication (primary)
- **Session persistence**: Firebase Auth handles session persistence automatically

### Authentication State Management
- **Global auth state**: Expose current user and auth state via Provider
- **Auth state stream**: Listen to `authStateChanges()` for reactive updates
- **User model**: Create a simple user model or use FirebaseAuth User directly

### Sign Up Flow
- **Email/password registration**: Use `createUserWithEmailAndPassword`
- **Form validation**: Validate email format and password strength (min 6 chars)
- **Error handling**: Display user-friendly error messages for common errors:
  - Email already in use
  - Invalid email format
  - Weak password
- **Success action**: Navigate to home page or previous page on successful signup

### Sign In Flow
- **Email/password login**: Use `signInWithEmailAndPassword`
- **Form validation**: Validate non-empty fields before submission
- **Error handling**: Display user-friendly error messages for:
  - Invalid credentials
  - User not found
  - Too many requests
- **Success action**: Navigate to home page or previous page on successful login

### Sign Out Flow
- **Sign out action**: Call `signOut()` method
- **State cleanup**: Clear any user-specific cached data
- **Navigation**: Redirect to home page after sign out

### Navbar Integration
- **Unauthenticated state**: Show "Login" link/button navigating to `/login`
- **Authenticated state**: Show user indicator (email or icon) with sign out option
- **Dropdown menu**: On desktop, show dropdown with "Sign Out" option
- **Mobile menu**: Include auth actions in mobile menu

### Route Protection (Optional/Future)
- **Protected routes**: Checkout page requires authentication
- **Redirect flow**: Redirect unauthenticated users to login, then back to original destination

## Implementation Details

### Files to Create/Modify

1. **Auth Service** (`/lib/services/auth_service.dart`):
   - Singleton or Provider-based service
   - Methods: `signIn()`, `signUp()`, `signOut()`, `getCurrentUser()`
   - Stream: `authStateChanges` for reactive auth state
   - Error handling with user-friendly messages

2. **Auth Provider** (`/lib/services/auth_provider.dart`) - if using ChangeNotifier:
   - Wrap AuthService for Provider consumption
   - Expose: `user`, `isAuthenticated`, `isLoading`, `error`
   - Methods: `signIn()`, `signUp()`, `signOut()`, `clearError()`

3. **Update Login/Signup Screen** (`/lib/screens/login_signup_screen.dart`):
   - Connect form submission to AuthService
   - Display loading state during auth operations
   - Show error messages from auth operations
   - Navigate on successful auth

4. **Update Main** (`/lib/main.dart`):
   - Add AuthProvider to provider tree
   - Initialize Firebase Auth (already done)

5. **Update Navbar** (`/lib/widgets/app_shell.dart` or navbar component):
   - Conditionally show login/user based on auth state
   - Add sign out action for authenticated users

6. **Update Router** (`/lib/router.dart`) - Optional:
   - Add redirect logic for protected routes
   - Pass auth state to route guards

### Technical Requirements
- Use `Provider` or `ChangeNotifierProvider` for auth state (consistent with existing cart)
- Handle async operations with loading states
- Dispose streams properly to prevent memory leaks
- Error messages should be user-friendly, not raw Firebase errors

### Error Message Mapping
Map Firebase Auth error codes to user-friendly messages:
- `email-already-in-use` → "An account with this email already exists"
- `invalid-email` → "Please enter a valid email address"
- `weak-password` → "Password must be at least 6 characters"
- `user-not-found` → "No account found with this email"
- `wrong-password` → "Incorrect password"
- `invalid-credential` → "Invalid email or password"
- `too-many-requests` → "Too many attempts. Please try again later"

### UI States
1. **Idle**: Form ready for input
2. **Loading**: Disable form, show loading indicator on button
3. **Error**: Display error message, re-enable form
4. **Success**: Navigate away from login screen

## Deliverables
1. Auth service file with Firebase Auth integration
2. Auth provider/state management file
3. Updated login/signup screen with working authentication
4. Updated navbar with auth-aware UI
5. Error handling with user-friendly messages
6. Loading states during auth operations
7. Widget tests for auth-dependent components

## Testing Considerations
- Mock FirebaseAuth for unit tests
- Test error handling for various auth scenarios
- Test auth state changes propagate to UI
- Test form validation before submission

## Notes
- Firebase is already initialized in `main.dart`
- Existing login/signup UI can be reused; connect to auth service
- Cart state does not need to persist across sessions (yet)
- Social auth (Google, Apple, etc.) can be added in a future phase
- Password reset flow can be added in a future phase
- Email verification can be added in a future phase
