# App Shell + Navbar - Requirements

## Overview

This feature extracts the top navigation bar (navbar) into a reusable widget and introduces an application shell that composes the shared navbar with page content. The goal is to centralize navigation UI and behavior so every route reuses the same navbar implementation, reducing duplication and ensuring consistent behavior and appearance across the app.

Why: Simplifies future changes to the navbar, improves consistency across pages, and reduces duplicated code.

Scope: affects the primary app UI and routes currently defined. It must preserve existing navigation behavior and visual appearance.

## User Stories

Each user story uses the form: As a <role>, I want <goal>, so that <benefit>.

1. As a first-time visitor, I want a consistent top navigation bar across pages, so I can quickly go back to the home page by tapping the logo.

2. As a returning shopper, I want product tiles and browse buttons to still open product details, so I don’t lose the expected workflow.

3. As a developer, I want to change the navbar in one place and have it appear everywhere, so that future updates are simple and consistent.

4. As a QA engineer, I want the navigation behavior (logo clears history, back button works for normal pushes) preserved, so regression bugs are avoided.

5. As an accessibility reviewer, I want tappable controls to meet size and semantic expectations, so users of assistive technologies have an equivalent experience.

## Acceptance Criteria (Testable)

Below are concrete, testable criteria. Each item should be verifiable by either a unit/widget test or a manual QA check.

1. Files and API
	- `lib/widgets/app_navbar.dart` exists and exports a `AppNavbar` widget encapsulating the previous navbar UI and logic.
	- `lib/widgets/app_shell.dart` exists and exports an `AppShell` widget that accepts at least `Widget child` and optional parameters for `title`, `floatingAction`, and `bottomNav`.

2. Routing & Integration
	- The app's route table (registered in `lib/main.dart`) returns pages wrapped by `AppShell` (either by modifying the route builders or by updating page widgets themselves to be wrapped).
	- Named routes `'/'` and `'/product'` still resolve and render their expected content when launched directly (deep links continue to work).

3. Navigation Behavior
	- Tapping the logo calls a navigation action equivalent to `Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false)`: it navigates home and clears history. This must be tested using a widget test that simulates the tap and asserts that routes are removed.
	- Product tiles and browse buttons push to `'/product'` (or the existing behavior) and the back button returns to the previous screen.

4. Visual & Responsive Parity
	- At common viewport sizes (mobile narrow, tablet wide), the navbar layout and styling match the pre-refactor appearance within a small tolerance. Manual visual verification or golden tests can be used.
	- Responsive grid logic for product listings (based on `MediaQuery.of(context).size.width`) is unchanged.

5. Accessibility & Semantics
	- The navbar's tappable controls meet a minimum target size of 48x48 logical pixels (where applicable).
	- Images in the navbar include semantic labels where reasonable (e.g., logo image includes semantic label like "Home"), and `errorBuilder` behavior for images remains unchanged.

6. Tests
	- A widget test exists that renders `AppNavbar` and verifies the presence of the logo, at least one navigation button, and that tapping the logo triggers the home navigation with history cleared.
	- A widget or integration test renders a route through the app's route table to verify that the page is wrapped with `AppShell` and displays the expected child content.


## Edge Cases & Non-functional Requirements

- Deep linking: launching any named route directly should still render the page within `AppShell` (or the same visual shell) and should not crash.
- Back navigation: for standard push navigation, the back button should pop to the previous page; only the logo action should clear history.
- Performance: the refactor should not negatively impact frame performance. Widgets must remain const where appropriate and avoid unnecessary rebuilds.

## Accessibility Checklist

- All interactive icons and images in the navbar have semantic labels where meaningful.
- Tappable areas meet 48x48 logical pixel minimum where applicable.
- Contrast and font sizing should remain unchanged from pre-refactor.

## Implementation Subtasks (Deliverable checklist)

All subtasks should be completed before marking the feature done.

- [ ] Create `lib/widgets/app_navbar.dart` that contains `AppNavbar` widget. Purpose: encapsulate UI and navigation behavior (logo tap, any buttons).
- [ ] Create `lib/widgets/app_shell.dart` that contains `AppShell` widget: takes `Widget child`, optional `title`, `floatingAction`, `bottomNav` and composes `AppNavbar` above the child.
- [ ] Update `lib/main.dart` to register routes that return `AppShell(child: ...)`, preserving current route names.
- [ ] Update `lib/product_page.dart` (if needed) so its content is used as the `child` of `AppShell` rather than re-creating a navbar inside the page.
- [ ] Add widget tests:
  - `test/widgets/app_navbar_test.dart`: verifies logo presence, accessibility semantics, and that logo tap navigates home and clears history.
  - `test/widgets/app_shell_route_test.dart`: verifies a route returns `AppShell` and shows child content.
- [ ] Manual visual verification at mobile and tablet sizes (or create golden tests if desired).
- [ ] Run analyzer and tests; fix any issues and ensure build passes.

## QA & PR Checklist

- [ ] App builds and runs without runtime exceptions.
- [ ] Navbar UI visually matches pre-refactor behavior on mobile and tablet.
- [ ] Logo tap navigates to `'/'` and clears history.
- [ ] Product tile and browse product navigation flows work unchanged.
- [ ] Added tests exist and pass.
- [ ] Accessibility checks performed for semantics and tappable area size.

