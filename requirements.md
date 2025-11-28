# Union Shop - Requirements

---

## 1. App Shell + Navbar

### Description
Extract the top navigation bar into a reusable `AppNavbar` widget and introduce an `AppShell` component that composes the navbar with page content. This centralizes navigation UI, reduces duplication, and ensures consistent behavior and appearance across all routes.

### User Stories
- As a visitor, I want a consistent top navbar across pages so I can quickly navigate home by tapping the logo.
- As a shopper, I want product tiles and browse buttons to still open product details without workflow changes.
- As a developer, I want to change the navbar in one place and have it appear everywhere.
- As a QA engineer, I want logo tap to clear history while back button works normally for standard pushes.
- As an accessibility reviewer, I want tappable controls to meet size and semantic expectations.

### Acceptance Criteria
- `lib/widgets/app_navbar.dart` exports `AppNavbar` widget with logo and navigation buttons.
- `lib/widgets/app_shell.dart` exports `AppShell` accepting `child`, optional `title`, `floatingAction`, `bottomNav`.
- Routes in `lib/main.dart` return pages wrapped by `AppShell`.
- Named routes `'/'` and `'/product'` resolve correctly (deep links work).
- Logo tap calls `Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false)`.
- Product tiles push to `'/product'`; back button pops normally.
- Navbar layout matches pre-refactor at mobile/tablet sizes.
- Tappable controls meet 48x48 logical pixel minimum.
- Images include semantic labels; `errorBuilder` behavior unchanged.
- Widget tests verify logo presence, tap navigation, and `AppShell` wrapping.

### Subtasks
- [ ] Create `lib/widgets/app_navbar.dart` with `AppNavbar` widget.
- [ ] Create `lib/widgets/app_shell.dart` with `AppShell` widget.
- [ ] Update `lib/main.dart` routes to use `AppShell`.
- [ ] Update `lib/product_page.dart` to use `AppShell` child pattern.
- [ ] Add `test/widgets/app_navbar_test.dart`.
- [ ] Add `test/widgets/app_shell_route_test.dart`.
- [ ] Manual visual verification at mobile/tablet sizes.

---

## 2. About Page

### Description
Add a simple, accessible, responsive "About us" page with organization information, expose a persistent link from the navbar, and ensure the page is reachable via deep link `/about` and standard navigation.

### User Stories
- As a visitor, I want an "About" page explaining who the store is so I can learn about the service.
- As a customer, I want to open the About page from any screen using the navbar.
- As a developer, I want About content as a single widget/route for easy maintenance.
- As a QA engineer, I want `/about` reachable by deep link and navbar across pages.

### Acceptance Criteria
- `lib/screens/about_page.dart` exports `AboutPage` StatelessWidget.
- Route `/about` registered and returns `AboutPage` (wrapped by `AppShell`).
- Page shows centered "About us" title using theme headline style.
- Page contains 4–6 paragraphs; content is scrollable on small screens.
- Navbar includes "About" item that calls `Navigator.pushNamed(context, '/about')` (does NOT clear history).
- Back button pops `/about` route normally.
- Widget test navigates to `/about` and asserts title and paragraph presence.

### Subtasks
- [ ] Create `lib/screens/about_page.dart` with `AboutPage`.
- [ ] Register `/about` route in `lib/main.dart`.
- [ ] Add "About" link to `AppNavbar`.
- [ ] Add widget test for About page.
- [ ] Manual verification on mobile/tablet.

---

## 3. Collections Page

### Description
Display product collections as an interactive grid of image tiles with overlaid text, allowing users to browse curated groups. The grid is responsive, provides tap feedback, and navigates to collection detail pages.

### User Stories
- As a mobile user, I want collections in a 2-column grid that fits my phone screen.
- As a customer, I want to tap a collection tile and see visual feedback before navigating.
- As a tablet/desktop user, I want more columns to maximize screen space.
- As a customer, I want to see collection title overlaid on each tile image.

### Acceptance Criteria
- Grid uses `GridView.builder`; 2 columns (<600px), 3 columns (600–900px), 4 columns (>900px).
- Tiles maintain square aspect ratio with consistent padding (8–16dp).
- Background image uses `BoxFit.cover`; text overlay has semi-opaque gradient for contrast.
- `FadeInImage` or shimmer placeholder while loading; fallback on error.
- `InkWell` provides ripple feedback; `onTap` triggers navigation.
- 6–8 hardcoded sample collections with title and imageUrl.
- `CollectionTile` extracted to `lib/widgets/collection_tile.dart`.
- Widget tests verify tile count, tap callback, and responsive columns.

### Subtasks
- [ ] Create `lib/screens/collections_page.dart` with `CollectionsPage`.
- [ ] Create `lib/widgets/collection_tile.dart` with `CollectionTile`.
- [ ] Implement responsive grid logic.
- [ ] Add sample collection data.
- [ ] Add widget tests.

---

## 4. Collection Page (Detail)

### Description
Display a single collection's products in a responsive grid with header (title/description) and placeholder filter/sort controls. Users can tap product cards to view details.

### User Stories
- As a customer, I want to view products in an organized grid within a collection.
- As a customer, I want to see collection title and description at the top.
- As a customer, I want to tap a product card to view its details.
- As a customer, I want to see filter/sort dropdowns (non-functional placeholder).

### Acceptance Criteria
- Page displays hardcoded sample collection data (title, description, items).
- Header shows collection title and description with appropriate spacing.
- "Filter By" and "Sort By" dropdowns render side-by-side (UI-only).
- Grid: 2 columns (<600px), 3 columns (≥600px).
- Product cards show image, name, price; cards have tap feedback.
- Minimum 44x44dp tap targets; responsive on mobile/tablet/desktop.
- Reusable widgets for container, grid item cards, dropdowns.

### Subtasks
- [ ] Create `lib/screens/collection_page.dart` with `CollectionPage`.
- [ ] Create reusable product card widget.
- [ ] Create dropdown control widgets.
- [ ] Implement responsive grid.
- [ ] Add sample product data.

---

## 5. Product Page

### Description
Comprehensive product detail page displaying product info (image, name, price, description), variant selectors (color/size), quantity control, and "Add to Cart" button. Supports navigation back to parent collection.

### User Stories
- As a customer, I want to view detailed product information to make informed decisions.
- As a customer, I want to select color and size options before adding to cart.
- As a customer, I want to specify quantity before purchasing.
- As a customer, I want to add configured products to my cart.
- As a customer, I want to return to the collection view from the product page.

### Acceptance Criteria
- Product image displays with placeholder fallback.
- Name, price, discounted price (if applicable), and description are visible.
- Color dropdown renders only when colors available; size dropdown only when sizes available.
- Quantity selector defaults to 1; cannot go below 1.
- "Add to Cart" button validates quantity > 0 and required selections.
- "Back to Collection" button navigates to parent collection.
- Route receives product and collection as parameters.
- `Product` model includes `description`, `discountedPrice`, `colors`, `sizes`.

### Subtasks
- [ ] Update `Product` model with new fields.
- [ ] Create `lib/screens/product_page.dart` with `ProductPage`.
- [ ] Implement image display with placeholder.
- [ ] Implement variant dropdowns and quantity selector.
- [ ] Implement action buttons and navigation.
- [ ] Add widget tests.

---

## 6. Homepage Banner Carousel

### Description
Convert the static homepage banner into an interactive carousel displaying multiple promotional slides with navigation controls (prev/next buttons, indicator dots) and optional auto-play functionality.

### User Stories
- As a visitor, I want to browse carousel slides using navigation buttons.
- As a visitor, I want to jump directly to a slide by clicking indicator dots.
- As a visitor, I want slides to advance automatically so I can passively discover content.

### Acceptance Criteria
- Carousel displays one full-width slide at a time (image, heading, subtext).
- Previous/next buttons positioned on left/right sides; always visible.
- Indicator dots below carousel; active dot visually distinguished; dots are clickable.
- Smooth transitions; carousel loops at boundaries.
- Auto-play advances every 5 seconds; pauses on hover; resumes after mouse leaves.
- Responsive on mobile/tablet/desktop.
- Keyboard navigation and ARIA labels for accessibility.

### Subtasks
- [ ] Create carousel widget structure.
- [ ] Implement slide navigation logic.
- [ ] Implement indicator dots.
- [ ] Add auto-play with pause/resume.
- [ ] Add keyboard navigation and accessibility labels.
- [ ] Add responsive styling.

---

## 7. Login/Signup Page

### Description
Implement a login/signup page with form fields for username/email and password, mode toggle between login and signup, password visibility toggle, and optional "Remember me" checkbox and "Forgot password?" link. UI-only; no backend integration.

### User Stories
- As an existing customer, I want to log in using my credentials to access my account.
- As a new customer, I want to create an account through a signup form.
- As a user who forgot my password, I want to see a "Forgot password?" link.
- As a mobile/desktop user, I want the page to be responsive and usable on any device.

### Acceptance Criteria
- `lib/screens/login_signup_screen.dart` exports `LoginSignupScreen` StatefulWidget.
- Form uses `TextEditingController` for email/username and password.
- Password field has show/hide toggle icon.
- Mode toggle switches between login and signup; fields clear on switch.
- "Remember me" checkbox and "Forgot password?" link present (optional).
- Login/signup buttons styled and functional (UI-ready).
- Responsive layout; 48x48dp minimum touch targets.
- Controllers disposed properly.

### Subtasks
- [ ] Create `lib/screens/login_signup_screen.dart`.
- [ ] Implement form fields with controllers.
- [ ] Implement password visibility toggle.
- [ ] Implement mode toggle logic.
- [ ] Add optional checkbox and link.
- [ ] Style buttons and ensure responsiveness.

---

## 8. Responsive Navigation Bar with Mobile Menu

### Description
Implement a responsive navbar that displays horizontal links on desktop and a hamburger menu with slide-down animation on mobile. Page content shifts to accommodate the expanded mobile menu.

### User Stories
- As a mobile user, I want to access navigation through a hamburger icon so my small screen isn't cluttered.
- As a mobile user, I want to close the menu by tapping the hamburger icon again.
- As a desktop user, I want navigation links displayed horizontally without extra clicks.

### Acceptance Criteria
- MediaQuery detects screen width; layout changes at breakpoint.
- Hamburger icon visible only on small screens; hidden on desktop.
- Tapping hamburger toggles menu open/closed with smooth slide animation (~300ms).
- Page content animates down/up in sync with menu.
- Desktop shows horizontal navigation links; no hamburger icon.
- Existing navbar styling and branding maintained.

### Subtasks
- [ ] Implement MediaQuery breakpoint detection.
- [ ] Create mobile menu container with vertical links.
- [ ] Implement desktop horizontal layout.
- [ ] Build animation controller for menu transitions.
- [ ] Implement content shift animation.
- [ ] Integrate menu state toggle.
- [ ] Test on multiple device sizes.