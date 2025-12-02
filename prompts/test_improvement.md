# Test Improvement Plan

## Goal
Fix failing tests, create missing test infrastructure, and improve overall test coverage across the application. Maintain clear separation between **widget tests** (unit tests for individual widgets) and **integration tests** (testing navigation, provider interactions, and full app flows).

## Current State

### Test Results Summary
- **Total Tests:** 231
- **Passing:** 231 (100%)
- **Failing:** 0

### Completed Work

#### Phase 1: Test Infrastructure ✅
- Created `/test/helpers/widget_test_helper.dart` with simple widget test wrappers
- Updated `/test/helpers/mock_auth_service.dart` with complete mock implementation

#### Phase 2: Fix Failing Tests ✅
- Fixed all 49 previously failing tests
- Refactored tests to be proper widget tests (not integration tests)
- Removed navigation-dependent tests from widget test files

### Test Helper Architecture

**Widget Tests** (`widget_test_helper.dart`):
- `wrapWidget(child)` - Simple MaterialApp + Scaffold
- `wrapWidgetScrollable(child)` - Adds SingleChildScrollView
- `wrapWidgetWithProviders(child)` - Adds AuthProvider with MockAuthService
- `wrapWidgetWithProvidersScrollable(child)` - Both providers and scrolling
- `TestViewportSizes` - Standard viewport sizes (mobile, tablet, desktop)
- `WidgetTesterViewport` extension - For setting/resetting viewport

### Key Principles
1. **Widget tests** should NOT depend on GoRouter - they test rendering and callbacks
2. **Widget tests** should use mocks (MockAuthService) not real Firebase
3. **Navigation testing** belongs in integration tests or router tests
4. **AppShell provides scrolling** - screens should NOT add their own SingleChildScrollView

## Remaining Work

### Phase 3: Add Missing Test Coverage (Priority: Medium)

#### 3.1 Widget Tests to Create

**`test/widgets/carousel_test.dart`:**
- Test slide navigation (next/prev buttons)
- Test indicator dot rendering and click behavior
- Test boundary looping

**`test/widgets/product_card_test.dart`:**
- Test product info display (name, price, image)
- Test discounted price display
- Test tap callback invocation (use mock callback, not navigation)
- Test placeholder image on error

**`test/widgets/collection_tile_test.dart`:**
- Test title overlay rendering
- Test image background
- Test tap callback
- Test aspect ratio maintenance

**`test/widgets/navbar_desktop_test.dart`:**
- Test nav links rendering
- Test search icon presence
- Test cart icon with badge
- Test account button states (authenticated/unauthenticated)

**`test/widgets/navbar_mobile_test.dart`:**
- Test hamburger menu icon
- Test menu drawer opening
- Test mobile nav links

**`test/widgets/product_section_test.dart`:**
- Test section title rendering
- Test product grid layout
- Test "View All" button

**`test/widgets/control_section_test.dart`:**
- Test filter dropdown
- Test sort dropdown
- Test layout responsiveness

**`test/widgets/labeled_dropdown_selector_test.dart`:**
- Test label rendering
- Test dropdown options
- Test selection callback

#### 3.2 Model Tests to Create

**`test/models/carousel_slide_test.dart`:**
- Test model construction

#### 3.3 Service Tests to Create

**`test/services/auth_service_test.dart`:**
- Test sign in method calls
- Test sign up method calls
- Test sign out method calls
- Test auth state stream
- Test error handling (use MockFirebaseAuth)

#### 3.4 Screen Tests to Create

**`test/screens/home_page_test.dart`:** (rename from `home_test.dart`)
- Test carousel rendering
- Test product sections
- Test hero banner
- Test navigation to collections

**`test/screens/print_shack_about_page_test.dart`:**
- Test page content rendering
- Test responsive layout

**`test/screens/print_shack_form_page_test.dart`:**
- Test form fields
- Test validation
- Test submission

## File Structure After Implementation

```
test/
├── helpers/
│   ├── mock_auth_service.dart        # Mock AuthService for testing
│   └── widget_test_helper.dart       # Widget test wrappers (simple, no routing)
├── models/
│   ├── auth_provider_test.dart       # Existing
│   ├── cart_test.dart                # Existing
│   ├── carousel_slide_test.dart      # NEW
│   ├── collection_test.dart          # Existing
│   └── product_test.dart             # Existing
├── screens/
│   ├── about_page_test.dart          # Existing ✅
│   ├── cart_page_test.dart           # Existing
│   ├── checkout_page_test.dart       # Existing
│   ├── collection_page_test.dart     # Existing ✅
│   ├── collections_page_test.dart    # Existing
│   ├── login_signup_screen_test.dart # Existing
│   ├── print_shack_about_page_test.dart  # NEW
│   ├── print_shack_form_page_test.dart   # NEW
│   ├── product_page_test.dart        # Existing ✅
│   └── search_page_test.dart         # Existing
├── services/
│   └── auth_service_test.dart        # NEW
├── utils/
│   ├── auth_error_messages_test.dart # Existing
│   ├── responsive_test.dart          # Existing
│   └── slug_test.dart                # Existing
├── widgets/
│   ├── app_footer_test.dart          # Existing ✅
│   ├── app_navbar_test.dart          # Existing
│   ├── app_shell_route_test.dart     # Existing ✅
│   ├── carousel_test.dart            # NEW
│   ├── collection_tile_test.dart     # NEW
│   ├── color_selector_test.dart      # Existing
│   ├── control_section_test.dart     # NEW
│   ├── labeled_dropdown_selector_test.dart  # NEW
│   ├── navbar_desktop_test.dart      # NEW
│   ├── navbar_mobile_test.dart       # NEW
│   ├── product_card_test.dart        # NEW
│   ├── product_section_test.dart     # NEW
│   ├── quantity_selector_test.dart   # Existing
│   ├── search_overlay_test.dart      # Existing
│   └── size_selector_test.dart       # Existing
├── home_test.dart                    # Existing ✅
└── router_test.dart                  # Existing
```

## Success Criteria

- [x] All existing tests pass (100% pass rate)
- [x] Test helper utilities created and documented
- [ ] Missing widget tests created
- [ ] Missing model tests created
- [ ] Missing service tests created
- [ ] Missing screen tests created
- [ ] Code coverage exceeds 80% for all modules
- [x] No test relies on network resources or Firebase

## Implementation Order

1. ~~**Create test helpers** (`widget_test_helper.dart`)~~ ✅
2. ~~**Fix all failing tests**~~ ✅
3. **Add widget tests** (carousel, product_card, collection_tile first)
4. **Add model tests** (carousel_slide)
5. **Add service tests** (auth_service)
6. **Add screen tests** (print_shack pages)

## Notes

- Use `tester.binding.setSurfaceSize()` for responsive layout tests
- Always dispose providers in `tearDown()`
- Use `pumpAndSettle()` for animations, `pump()` for immediate assertions
- Avoid `pumpAndSettle()` with infinite animations (loading spinners)
- Mock all external dependencies (Firebase, network)
- **Widget tests should NOT test navigation** - use callbacks or verify widget state only
