# Test Improvement Plan

## Goal
Fix failing tests, create missing test infrastructure, and improve overall test coverage across the application. The current test suite has a 78.6% pass rate (180/229 tests) with critical infrastructure issues that need to be resolved before adding new test coverage.

## Current State Analysis

### Test Results Summary
- **Total Tests:** 229
- **Passing:** 180 (78.6%)
- **Failing:** 49 (21.4%)

### Root Causes of Failures

#### 1. Missing Provider Setup
Tests fail with `ProviderNotFoundException` because widgets require `AuthProvider` and `CartProvider` but tests don't provide them. The navbar's `Consumer<AuthProvider>` widget is the primary failure point.

**Affected files:**
- `test/widgets/app_shell_route_test.dart`
- `test/screens/product_page_test.dart`
- `test/home_test.dart`
- `test/widgets/app_footer_test.dart`

#### 2. Image Loading in Test Environment
Tests using network URLs (`https://via.placeholder.com/...`) fail because Flutter's test environment treats these as asset paths, not network images.

#### 3. Missing GoRouter Context
`app_footer_test.dart` fails because navigation actions require `GoRouter` in the widget tree.

#### 4. Layout Overflow Warnings
Navbar tests have `RenderFlex` overflow issues due to default 800x600 test viewport being too small.

### Coverage Gaps

| Area | Source Files | Test Files | Missing Tests |
|------|--------------|------------|---------------|
| **Screens** | 11 | 8 | `home.dart`, `print_shack_about_page.dart`, `print_shack_form_page.dart` |
| **Widgets** | 16 | 7 | `carousel.dart`, `collection_tile.dart`, `control_section.dart`, `labeled_dropdown_selector.dart`, `navbar_desktop.dart`, `navbar_mobile.dart`, `product_card.dart`, `product_section.dart` |
| **Models** | 5 | 4 | `carousel_slide.dart` |
| **Services** | 1 | 0 | `auth_service.dart` |
| **Utils** | 3 | 3 | ✅ Full coverage |
| **Router** | 1 | 1 | ✅ Covered |

## Implementation Plan

### Phase 1: Test Infrastructure (Priority: Critical)

#### 1.1 Create Test Helper Utilities

Create `/test/helpers/test_app_wrapper.dart`

#### 1.2 Create Mock Image Provider

Create `/test/helpers/mock_image_provider.dart`

#### 1.3 Update Existing Mock Auth Service

Ensure `/test/helpers/mock_auth_service.dart` is complete with all required methods for comprehensive testing.

### Phase 2: Fix Failing Tests (Priority: High)

#### 2.1 Fix `home_test.dart`
- Wrap `UnionShopApp` with providers or create a testable version
- Add larger viewport size for navbar tests
- Update assertions to match current UI (footer text changed)

#### 2.2 Fix `app_shell_route_test.dart`
- Use `buildTestableWidget` helper
- Provide mock GoRouter for navigation tests

#### 2.3 Fix `product_page_test.dart`
- Use `buildTestableWidget` helper
- Mock product images

#### 2.4 Fix `app_footer_test.dart`
- Wrap with GoRouter using `createTestRouter`
- Use provider wrapper

#### 2.5 Fix `collection_page_test.dart` Image Errors
- Use mock image provider
- Consider using placeholder asset images for tests

### Phase 3: Add Missing Test Coverage (Priority: Medium)

#### 3.1 Widget Tests to Create

**`test/widgets/carousel_test.dart`:**
- Test slide navigation (next/prev buttons)
- Test indicator dot rendering and click behavior
- Test boundary looping

**`test/widgets/product_card_test.dart`:**
- Test product info display (name, price, image)
- Test discounted price display
- Test tap callback invocation
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
│   ├── mock_auth_service.dart        # Existing, update if needed
│   ├── test_app_wrapper.dart         # NEW: Provider wrapper
│   └── mock_image_provider.dart      # NEW: Image mocking
├── models/
│   ├── auth_provider_test.dart       # Existing
│   ├── cart_test.dart                # Existing
│   ├── carousel_slide_test.dart      # NEW
│   ├── collection_test.dart          # Existing
│   └── product_test.dart             # Existing
├── screens/
│   ├── about_page_test.dart          # Existing
│   ├── cart_page_test.dart           # Existing
│   ├── checkout_page_test.dart       # Existing
│   ├── collection_page_test.dart     # Existing, FIX
│   ├── collections_page_test.dart    # Existing
│   ├── home_page_test.dart           # Existing, FIX
│   ├── login_signup_screen_test.dart # Existing
│   ├── print_shack_about_page_test.dart  # NEW
│   ├── print_shack_form_page_test.dart   # NEW
│   ├── product_page_test.dart        # Existing, FIX
│   └── search_page_test.dart         # Existing
├── services/
│   └── auth_service_test.dart        # NEW
├── utils/
│   ├── auth_error_messages_test.dart # Existing
│   ├── responsive_test.dart          # Existing
│   └── slug_test.dart                # Existing
├── widgets/
│   ├── app_footer_test.dart          # Existing, FIX
│   ├── app_navbar_test.dart          # Existing
│   ├── app_shell_route_test.dart     # Existing, FIX
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
├── home_test.dart                    # Existing, FIX/rename
└── router_test.dart                  # Existing
```

## Success Criteria

- [ ] All existing tests pass (100% pass rate)
- [ ] Test helper utilities created and documented
- [ ] Missing widget tests created
- [ ] Missing model tests created
- [ ] Missing service tests created
- [ ] Missing screen tests created
- [ ] Code coverage exceeds 80% for all modules
- [ ] No test relies on network resources

## Implementation Order

1. **Create test helpers** (`test_app_wrapper.dart`, `mock_image_provider.dart`)
2. **Fix `home_test.dart`** - most visible test file
3. **Fix `app_shell_route_test.dart`** - foundation for other tests
4. **Fix `product_page_test.dart`** - common pattern
5. **Fix `app_footer_test.dart`** - navigation testing
6. **Fix `collection_page_test.dart`** - image loading
7. **Add widget tests** (carousel, product_card, collection_tile first)
8. **Add model tests** (carousel_slide)
9. **Add service tests** (auth_service)
10. **Add screen tests** (print_shack pages)

## Notes

- Use `tester.binding.setSurfaceSize()` for responsive layout tests
- Always dispose providers in `tearDown()`
- Use `pumpAndSettle()` for animations, `pump()` for immediate assertions
- Avoid `pumpAndSettle()` with infinite animations (loading spinners)
- Mock all external dependencies (Firebase, network)
