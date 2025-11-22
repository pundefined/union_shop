# App Shell + Navbar - Requirements

## Overview

This feature extracts the top navigation bar (navbar) into a reusable widget and introduces an application shell that composes the shared navbar with page content. The goal is to centralize navigation UI and behavior so every route reuses the same navbar implementation, reducing duplication and ensuring consistent behavior and appearance across the app.

Why: Simplifies future changes to the navbar, improves consistency across pages, and reduces duplicated code.

Scope: affects the primary app UI and routes currently defined. It must preserve existing navigation behavior and visual appearance.

## User Stories

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


## About Page - Requirements

### Overview

This feature adds a simple, accessible, responsive "About us" page to the storefront and exposes a persistent link to it from the top navigation bar so users can reach it from any main screen.

Purpose: provide a place for organisation information and customer-facing copy. The page should be visually consistent with the app theme, accessible, scrollable on small screens, and reachable via the app's navbar and deep links.

Scope: introduce an `AboutPage` widget, register a named route `/about`, add an "About" navigation item to the primary navbar, and add tests that verify navigation and content.

### User Stories

1. As a new visitor, I want an "About" page that explains who the store is, so I can learn about the service and contact details.
2. As a returning customer, I want to open the About page from any screen using the navbar, so I can quickly check policies or contact information.
3. As a developer, I want the About content implemented as a single widget and route, so it can be reused and maintained easily.
4. As a QA engineer, I want the About page to be reachable by deep link (`/about`) and via the navbar across pages, so navigation regressions can be detected early.

### Acceptance Criteria (Testable)

Below are concrete, testable criteria for determining feature completeness.

1. Files & API
	- `lib/screens/about_page.dart` exists and exports a `AboutPage` StatelessWidget that renders the page content.
	- The app's route table includes a named route `/about` mapped to a builder that returns the `AboutPage` (ideally wrapped by `AppShell` if the shell is used globally).

2. Content & Layout
	- The page shows a centered title reading "About us" using the app's theme headline style (e.g., `Theme.of(context).textTheme.headline*`).
	- The page contains 4–6 short paragraphs of placeholder or real copy. Tests should assert the presence of at least one paragraph and the title.
	- Content is horizontally centered within a comfortable maximum width (e.g., limited width on large screens) and has clear vertical spacing between paragraphs.
	- The page is vertically scrollable when vertical space is constrained (small/mobile screens).

3. Navigation & Routing
	- The top navbar includes an item labeled "About". Tapping the item pushes the `/about` route via `Navigator.pushNamed(context, '/about')` (i.e., regular push — it must NOT clear history).
	- Navigating to `/about` directly (deep link / initial route) displays the `AboutPage` (within `AppShell` if the app uses it) without crashes.
	- The back button (system or app) pops the `/about` route returning to the previous page.

4. Tests
	- `test/screens/about_page_test.dart` exists and contains a widget test that:
	  - pumps the app (using the app's route table), navigates to `/about` (either by calling `pushNamed` or by launching the route directly), and asserts the title "About us" is present and at least one paragraph is visible.
	- Optionally, a golden or layout test verifies the About page layout on a narrow and wide viewport.

### Implementation Subtasks (Deliverable checklist)

Add these subtasks and mark them complete when done.

- [ ] Create file containing `AboutPage` (StatelessWidget) with the required title and 4–6 paragraphs of content, using theme text styles and respecting dark mode.
- [ ] Register a named route `/about` in the app's route table (e.g., in `lib/main.dart`) that returns `AboutPage`. Ensure deep links resolve to this route.
- [ ] Add an "About" item/link to the primary navbar (`AppNavbar` or equivalent) that calls `Navigator.pushNamed(context, '/about')` and includes a semantic label and minimum tappable size.
- [ ] Add a widget test that pumps the app, navigates to `/about`, and asserts title and paragraph presence.
- [ ] (Optional) Add a golden/layout test to validate responsive layout on narrow and wide viewports.
- [ ] Manually verify the page on mobile and tablet viewports for visual parity and accessibility.
- [ ] Run analyzer and tests; fix any issues.

### QA Checklist

- [ ] `/about` route opens About page when navigated to directly.
- [ ] Navbar "About" link opens About page without clearing history.
- [ ] Title and at least one paragraph are visible in tests.
- [ ] Tappable area and semantic labels meet accessibility expectations.
- [ ] Page scrolls when content exceeds viewport height.

# Collections Page — Detailed Requirements Document

## 1. Feature Overview

### Purpose
The Collections page provides users with an organized, visually appealing way to browse product collections in the union_shop Flutter application. Collections are displayed as an interactive grid of image tiles with overlaid text, allowing users to quickly explore curated product groups (e.g., "Summer Sale", "New Arrivals", "Clearance").

### Key Objectives
- Present multiple collections in a scannable grid format
- Ensure text readability on image backgrounds through contrast techniques
- Provide responsive design for mobile, tablet, and desktop viewports
- Offer intuitive tap interaction with visual feedback

---

## 2. User Stories

### User Story 1: Browse Collections on Mobile
**As a** mobile user shopping for products  
**I want to** see collections displayed in a grid that fits my phone screen  
**So that** I can quickly scan available product categories without excessive scrolling

**Acceptance Criteria:**
- Grid displays 2 columns on screens < 600px wide
- Each tile is square or 3:4 aspect ratio
- Text is clearly visible and centered on each tile
- Consistent padding between tiles

---

### User Story 2: Tap and Navigate to Collection
**As a** customer interested in a specific collection  
**I want to** tap a collection tile and see visual feedback  
**So that** I know my interaction was registered and I can proceed to view that collection

**Acceptance Criteria:**
- Tapped tile displays ripple/ink animation
- onTap callback is triggered
- No lag or stuttering in feedback animation

---

### User Story 3: View Collections on Tablet/Desktop
**As a** desktop or tablet user  
**I want to** see more collections per row to maximize screen space  
**So that** I can view more options without scrolling

**Acceptance Criteria:**
- Grid displays 3 columns on screens 600–900px wide
- Grid displays 4 columns on screens > 900px wide
- Layout adjusts smoothly when window is resized
- Tiles maintain proper aspect ratio and spacing

---

### User Story 4: View Collection Metadata
**As a** customer browsing collections  
**I want to** see the collection title and optional subtitle/description overlaid on the image  
**So that** I understand what each collection contains at a glance

**Acceptance Criteria:**
- Title is prominently displayed and readable
- Text contrast meets WCAG AA standards
- Text does not overflow or clip tile boundaries

---

## 3. Detailed Acceptance Criteria

### Grid & Layout
- [ ] Grid uses `GridView.builder` for efficient rendering
- [ ] Responsive column count:
  - [ ] 2 columns for screen width < 600px
  - [ ] 3 columns for screen width 600–900px
  - [ ] 4 columns for screen width > 900px
- [ ] Column count updates when screen is resized
- [ ] Consistent padding/margin between tiles (8–16dp recommended)
- [ ] Tiles maintain square aspect ratio

### Tile Design & Appearance
- [ ] Background image covers entire tile (BoxFit.cover)
- [ ] Subtle shadow or elevation applied to tile
- [ ] Centered text overlay with semi-opaque dark gradient behind it
- [ ] Text color contrasts adequately with background

### Image Loading & Error Handling
- [ ] `FadeInImage` or similar used for smooth load transitions
- [ ] Placeholder/shimmer displayed while image loads
- [ ] Placeholder uses neutral color (e.g., light gray)
- [ ] Error state shows fallback placeholder image
- [ ] No console warnings or errors when image fails to load
- [ ] Loading/error states are visually distinct from loaded state

### Interactivity & Tap Feedback
- [ ] Tapping a tile triggers `onTap` callback
- [ ] `InkWell` provides Material ripple feedback
- [ ] Ripple animation is smooth and responsive
- [ ] Tap feedback is immediate (no noticeable delay)
- [ ] Callback can log event or navigate (implementation deferred)

### Content & Data
- [ ] 6–8 hardcoded sample collections provided
- [ ] Each collection includes:
  - [ ] Unique title (e.g., "Summer Sale", "New Arrivals")
  - [ ] Image URL or asset path
  - [ ] Optional description/subtitle
- [ ] Data is stored as list of maps or simple objects
- [ ] No null/undefined values in sample data

### Code Quality
- [ ] `CollectionsPage` widget created and self-contained
- [ ] `CollectionTile` sub-widget created and reusable
- [ ] Code is well-commented and easy to understand
- [ ] No hardcoded magic numbers; use constants for spacing/sizing
- [ ] Widgets follow Flutter conventions and best practices

### Testing
- [ ] Unit/widget test verifies grid renders correct tile count
- [ ] Test verifies tap callback is triggered
- [ ] Test verifies responsive column count at different widths
- [ ] Tests are clear and maintainable


## 4. Deliverables Checklist

### Code
- [ ] `collections_page.dart` – Complete CollectionsPage + CollectionTile widgets
- [ ] `collections_page_test.dart` – Widget tests covering grid, responsiveness, tap behavior

### Documentation
- [ ] Inline code comments explaining key sections
- [ ] README or doc comment describing widget usage

### Testing
- [ ] All acceptance criteria verified
- [ ] Widget tests pass on all target platforms
- [ ] No console warnings or errors