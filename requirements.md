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

# Collection Page Feature - Requirements Document

## 1. Feature Description

### Purpose
The Collection Page enables customers to browse a curated collection of products in an organized, visually appealing grid layout. This page serves as a hub for discovering products within a specific category or theme, with UI controls for filtering and sorting to enhance the shopping experience.

### Scope
- Display a collection with header information (title and description)
- Present products in a responsive grid layout
- Provide filter and sort UI controls (non-functional for now)
- Ensure mobile and desktop responsiveness
- Create reusable widget components for maintainability

---

## 2. User Stories

### Story 1: Customer Browses Collection
**As a** customer  
**I want to** view a collection of products in an organized grid layout  
**So that** I can easily discover and compare items within the collection

**Acceptance Criteria:**
- Grid displays 2 columns on mobile, 3 columns on tablet/desktop
- Each product card shows image, name, and price
- Cards are properly spaced with consistent padding
- Layout is responsive and adapts to different screen sizes

---

### Story 2: Customer Explores Collection Details
**As a** customer  
**I want to** see the collection title and description at the top of the page  
**So that** I understand what the collection is about

**Acceptance Criteria:**
- Collection title is prominently displayed
- Description text appears directly below the title
- Typography is consistent with existing storefront design
- Text is readable on all screen sizes

---

### Story 3: Customer Interacts with Product Cards
**As a** customer  
**I want to** tap on a product card to view details  
**So that** I can learn more about a specific product

**Acceptance Criteria:**
- Product cards are clearly clickable/tappable
- Cards have sufficient size and padding for easy interaction
- Visual feedback (hover/pressed state) indicates interactivity
- Tap leads to product detail page (or placeholder behavior)

---

### Story 4: Customer Sees Filter and Sort Options
**As a** customer  
**I want to** see filter and sort dropdown controls  
**So that** I know filtering and sorting capabilities will be available

**Acceptance Criteria:**
- "Filter By" dropdown is visible and styled consistently
- "Sort By" dropdown is visible and styled consistently
- Dropdowns are positioned side-by-side in the control section
- Dropdowns are UI-only (non-functional) for this phase

---

## 3. Acceptance Criteria

### Functional Requirements

#### FR-1: Collection Page Display
- [ ] Page displays hardcoded sample collection data (title, description, items)
- [ ] Page renders without errors on initial load
- [ ] All page sections load within 2 seconds

#### FR-2: Header Section
- [ ] Collection title displays prominently at the top
- [ ] Description text displays below the title with appropriate spacing
- [ ] Text content is truncated or wrapped appropriately for all screen sizes

#### FR-3: Control Section
- [ ] "Filter By" dropdown renders with placeholder text
- [ ] "Sort By" dropdown renders with placeholder text
- [ ] Both dropdowns are positioned horizontally side-by-side
- [ ] Dropdowns have consistent styling and spacing
- [ ] Dropdowns are tappable but non-functional

#### FR-4: Items Grid
- [ ] Grid displays 2 columns on screens < 600px width
- [ ] Grid displays 3 columns on screens ≥ 600px width
- [ ] Each grid item displays product image, name, and price
- [ ] Grid items have consistent spacing and padding
- [ ] All items are visible without horizontal scrolling

#### FR-5: Grid Item Cards
- [ ] Product image displays with appropriate aspect ratio (e.g., 1:1 or 3:4)
- [ ] Product name displays below the image
- [ ] Price displays below the product name
- [ ] Cards have sufficient tap target size (minimum 44x44 dp)
- [ ] Cards show visual feedback on tap (opacity change or elevation)

#### FR-6: Responsiveness
- [ ] Layout adapts correctly for mobile (320px+)
- [ ] Layout adapts correctly for tablet (600px+)
- [ ] Layout adapts correctly for desktop (900px+)
- [ ] Images scale appropriately without distortion
- [ ] No horizontal scrolling on any screen size

### Non-Functional Requirements

#### NF-1: Code Quality
- [ ] Reusable widget created for collection page container
- [ ] Reusable widget created for grid item cards
- [ ] Reusable widget created for dropdown controls
- [ ] Code follows Flutter/Dart style guidelines
- [ ] Code is properly documented with comments

#### NF-2: Design Consistency
- [ ] Styling matches existing storefront design system
- [ ] Colors, fonts, and spacing are consistent with app theme
- [ ] Component interactions follow established patterns

#### NF-3: Performance
- [ ] Page builds in under 500ms
- [ ] Images load without jank or frame drops
- [ ] Scrolling performance is smooth (60 fps)

#### NF-4: Accessibility
- [ ] All interactive elements have sufficient contrast ratio
- [ ] Tap targets are minimum 44x44 dp for touch accessibility
- [ ] Semantic labels are present for screen readers

---

## 4. Test Scenarios

### Scenario 1: Mobile View (Portrait)
- [ ] Verify 2-column grid layout on 375px width device
- [ ] Verify images scale correctly
- [ ] Verify no horizontal overflow

### Scenario 2: Tablet View (Landscape)
- [ ] Verify 3-column grid layout on 768px width device
- [ ] Verify spacing remains consistent

### Scenario 3: Desktop View
- [ ] Verify 3-column grid layout on desktop resolution
- [ ] Verify optimal spacing and readability

### Scenario 4: Product Card Interaction
- [ ] Verify tap feedback is visible
- [ ] Verify navigation occurs on tap (if implemented)

### Scenario 5: Data Integrity
- [ ] Verify all hardcoded sample data displays correctly
- [ ] Verify no missing images or prices
- [ ] Verify proper formatting of prices

# Product Page Feature - Detailed Requirements Document

## 1. Feature Description

### Purpose
Implement a comprehensive product detail page in a Flutter application that enables users to view detailed product information, configure product options (color, size, quantity), and add items to their shopping cart. This feature bridges the gap between product discovery (collection view) and purchase, providing an essential e-commerce functionality.

### Scope
- Display detailed product information on a dedicated page
- Provide interactive UI controls for product configuration
- Manage product selection state during the user session
- Enable seamless navigation between product and collection views

---

## 2. User Stories

### User Story 1: Viewing Product Details
**As a** customer browsing the shop  
**I want to** view detailed information about a product  
**So that** I can make an informed decision about purchasing

**Acceptance Criteria:**
- Product image displays correctly with a placeholder if unavailable
- Product name, price, and description are clearly visible
- Discounted price is displayed prominently when available
- All text is readable and properly formatted

### User Story 2: Selecting Product Variants
**As a** customer shopping for clothing  
**I want to** select color and size options before adding to cart  
**So that** I can customize my purchase according to my preferences

**Acceptance Criteria:**
- Color dropdown appears only when colors are available
- Size dropdown appears only when sizes are available
- Selected values persist while on the product page
- All available options are displayed in dropdowns

### User Story 3: Configuring Quantity
**As a** customer making a purchase  
**I want to** specify the quantity I wish to buy  
**So that** I can purchase multiple items at once

**Acceptance Criteria:**
- Quantity selector starts at 1
- Quantity cannot be set below 1
- Users can increment/decrement quantity easily
- Current quantity is always visible

### User Story 4: Adding to Cart
**As a** customer ready to purchase  
**I want to** add configured products to my shopping cart  
**So that** I can proceed with checkout

**Acceptance Criteria:**
- "Add to Cart" button is always visible and accessible
- Button is enabled when quantity is greater than 0
- Selecting color/size is only required if options are available
- Cart addition is processed upon button click

### User Story 5: Navigating Back
**As a** customer browsing products  
**I want to** return to the collection view from a product page  
**So that** I can continue shopping for other items

**Acceptance Criteria:**
- "Back to Collection" button navigates to the parent collection
- The collection view maintains its previous scroll position (if applicable)
- Navigation is seamless and immediate

---

## 3. Acceptance Criteria

### 3.1 Data Model
- [ ] `Product` model includes `description` field (String)
- [ ] `Product` model includes `discountedPrice` field (double, optional)
- [ ] `Product` model includes `colors` field (List<String>, optional)
- [ ] `Product` model includes `sizes` field (List<String>, optional)

### 3.2 UI/Layout Requirements
- [ ] Product image displays with proper aspect ratio
- [ ] Placeholder image appears when product image is unavailable
- [ ] Product name displays as a prominent heading
- [ ] Original price displays in primary text styling
- [ ] Discounted price displays with visual distinction (e.g., strikethrough on original, highlighted on discount)
- [ ] Product description text wraps correctly and is readable
- [ ] All UI elements are responsive and work on various screen sizes

### 3.3 Selection Controls
- [ ] Color dropdown renders only when `colors` list is not empty
- [ ] Size dropdown renders only when `sizes` list is not empty
- [ ] Dropdown values are pre-populated with available options
- [ ] Quantity selector displays with spinner/number input interface
- [ ] Quantity defaults to 1 and cannot go below 1

### 3.4 State Management
- [ ] Selected color is tracked in page state
- [ ] Selected size is tracked in page state
- [ ] Selected quantity is tracked in page state
- [ ] State updates reflect immediately in UI
- [ ] State is lost when navigating away from page (no persistence)

### 3.5 Action Buttons
- [ ] "Add to Cart" button is visible and properly labeled
- [ ] "Add to Cart" button is functional (placeholder implementation acceptable)
- [ ] "Add to Cart" validates that quantity > 0 before processing
- [ ] "Add to Cart" validates that required selections are made (color/size if applicable)
- [ ] "Back to Collection" button navigates to parent collection view
- [ ] Both buttons are easily accessible (not hidden below fold)

### 3.6 Navigation
- [ ] Product page receives product object as route parameter
- [ ] Product page receives parent collection object as route parameter
- [ ] Back button navigates with correct collection reference
- [ ] Route parameters are properly handled and validated

### 3.7 Error Handling
- [ ] Missing required fields display appropriate defaults or error messages
- [ ] Invalid route parameters are handled gracefully
- [ ] Empty product lists/strings are handled without crashes

### 3.8 Code Quality
- [ ] Code follows Flutter best practices and style guidelines
- [ ] UI components are modular and reusable where applicable
- [ ] State management is clean and maintainable
- [ ] Comments explain complex logic

---

## 4. Subtasks

### Phase 1: Data Model
- [ ] Update `Product` model with new fields
- [ ] Add validation for optional fields
- [ ] Create factory constructors for testing

### Phase 2: UI Implementation
- [ ] Create ProductPage widget structure
- [ ] Implement product image display with placeholder
- [ ] Implement product info section (name, price, description)
- [ ] Implement color selector dropdown
- [ ] Implement size selector dropdown
- [ ] Implement quantity selector

### Phase 3: State Management
- [ ] Initialize state variables for selections
- [ ] Implement state update logic for dropdown changes
- [ ] Implement state update logic for quantity changes
- [ ] Add validation logic

### Phase 4: Navigation & Actions
- [ ] Implement "Add to Cart" button logic
- [ ] Implement "Back to Collection" button logic
- [ ] Set up route parameter passing
- [ ] Test navigation flow

### Phase 5: Testing & Polish
- [ ] Unit test Product model
- [ ] Widget test ProductPage
- [ ] Manual testing on various devices
- [ ] Performance optimization if needed

# Collections Page Refactoring - Requirements Document

## 1. Feature Description

### Purpose
Refactor the Flutter e-commerce app's collections feature to improve code maintainability, reusability, and user experience by extracting components into separate files, using a centralized data model, and implementing proper navigation to collection detail pages.

### Scope
- Extract `CollectionTile` widget into a reusable component
- Integrate the centralized `Collection` model
- Replace SnackBar feedback with navigation to a dedicated collection details page
- Maintain visual design and responsive layout

---

## 2. User Stories

### User Story 1: Discover Collections
**As a** customer browsing the app
**I want to** see available product collections in a visually appealing grid layout
**So that** I can quickly identify collections that interest me

**Acceptance Criteria:**
- Collections are displayed in a responsive grid
- Each collection tile shows an image with overlay text (title)
- The grid adapts to different screen sizes
- The layout remains consistent with the current design

---

### User Story 2: Navigate to Collection Details
**As a** customer
**I want to** tap on a collection tile and view all products in that collection
**So that** I can browse products within a specific category

**Acceptance Criteria:**
- Tapping a collection tile navigates to a dedicated collection details page
- The collection details page displays products from the selected collection
- Navigation is smooth and responsive
- The tapped collection's data is correctly passed to the details page

---

## 3. Acceptance Criteria

### General Acceptance Criteria
- [ ] All code changes follow Flutter best practices
- [ ] No breaking changes to existing functionality
- [ ] App compiles and runs without errors
- [ ] The visual design and responsive layout are maintained

---

### Task 1: Extract CollectionTile - Acceptance Criteria
- [ ] New file `lib/widgets/collection_tile.dart` is created
- [ ] `CollectionTile` widget is moved from `collections_page.dart` to the new file
- [ ] All necessary imports are included in `collection_tile.dart`
- [ ] `collections_page.dart` imports and uses `CollectionTile` from the new file
- [ ] `CollectionTile` functions identically to before refactoring
- [ ] No compilation errors after extraction

---

### Task 2: Update Collection Model Usage - Acceptance Criteria
- [ ] `Collection` model is imported from `lib/models/collection.dart`
- [ ] Local `Collection` class is removed from `collections_page.dart`
- [ ] All collection references use the imported `Collection` model
- [ ] `Collection` model has `title` and `imageUrl` properties (or model is updated)
- [ ] `sampleCollections` list is updated to instantiate `Collection` objects
- [ ] Both `collections_page.dart` and `collection_tile.dart` use the imported model
- [ ] No compilation errors after model integration

---

### Task 3: Implement Navigation - Acceptance Criteria
- [ ] `CollectionTile` onTap handler uses `Navigator.pushNamed()` instead of SnackBar
- [ ] Navigation route is `'/collection'` (or verified existing route)
- [ ] `Collection` object is passed as an argument to the destination page
- [ ] Collection details page receives and displays the correct collection
- [ ] Products displayed on collection page match the selected collection
- [ ] Navigation is smooth with no visual glitches
- [ ] User can navigate back from collection details page

---

### Quality Assurance - Acceptance Criteria
- [ ] App renders collections grid without errors
- [ ] Each collection tile displays image and title correctly
- [ ] Tapping a tile navigates to collection details page
- [ ] Collection details page displays relevant products
- [ ] App maintains responsive design on various screen sizes
- [ ] No console errors or warnings
- [ ] Code is properly formatted and documented

# Homepage Banner Carousel - Requirements Document

## 1. Feature Description

### Purpose
Convert the static homepage banner into an interactive carousel component that displays multiple slides sequentially. This allows the union shop to showcase multiple promotional content, featured products, or announcements in a single, space-efficient banner area while providing an engaging user experience.

### Scope
- Replace existing static banner with dynamic carousel
- Support multiple slides with images, headings, and subtext
- Implement navigation controls (previous/next buttons and indicator dots)
- Optional auto-play functionality with user pause capability

---

## 2. User Stories

### User Story 1: Basic Navigation
**As a** website visitor  
**I want to** browse through multiple carousel slides using navigation buttons  
**So that** I can view different promotional content without leaving the homepage

**Acceptance Criteria:**
- Next button advances to the following slide
- Previous button returns to the prior slide
- Navigation loops (next from last slide goes to first; previous from first goes to last)
- Transitions are smooth and visually clear

### User Story 2: Direct Slide Selection
**As a** website visitor  
**I want to** jump directly to a specific slide by clicking indicator dots  
**So that** I can quickly access content I'm interested in without sequential clicking

**Acceptance Criteria:**
- Indicator dots are visible below the carousel
- Clicking a dot displays the corresponding slide
- The active dot is visually distinguished from inactive dots
- Transition to selected slide is smooth

### User Story 3: Auto-Play Experience
**As a** website visitor  
**I want to** see carousel slides advance automatically  
**So that** I can passively discover content without manual interaction

**Acceptance Criteria:**
- Carousel advances automatically every 5 seconds
- Auto-play pauses on mouse hover
- Auto-play resumes when mouse leaves the carousel area
- User can still manually navigate during auto-play

---

## 3. Acceptance Criteria

### Functional Requirements

#### 3.1 Slide Display
- [ ] Carousel displays one full-width slide at a time
- [ ] Each slide contains a background image, primary heading text, and secondary subtext
- [ ] Slides are properly sized and responsive across device sizes

#### 3.2 Navigation Controls
- [ ] "Previous" (left arrow) button is positioned on the left side
- [ ] "Next" (right arrow) button is positioned on the right side
- [ ] Buttons are clickable and styled appropriately
- [ ] Buttons are always visible and accessible

#### 3.3 Indicator Dots
- [ ] One dot appears for each slide below the carousel
- [ ] Active dot is highlighted/distinguished visually
- [ ] Inactive dots have lighter styling
- [ ] Each dot is clickable and navigates to the corresponding slide

#### 3.4 Transition Behavior
- [ ] All slide transitions are smooth (no jarring visual jumps)
- [ ] Carousel loops correctly (last slide → first slide, first slide → last slide)
- [ ] Navigation state updates correctly after transitions

#### 3.5 Auto-Play Functionality (Optional)
- [ ] Carousel auto-advances every 5 seconds by default
- [ ] Auto-play pauses on mouse hover over carousel
- [ ] Auto-play resumes 2 seconds after mouse leaves carousel
- [ ] Manual navigation resets the auto-play timer

### Non-Functional Requirements

#### 3.6 Performance
- [ ] Carousel loads without noticeable delay
- [ ] Transitions are smooth (60fps target)
- [ ] Memory usage is optimal with multiple slides

#### 3.7 Accessibility
- [ ] WCAG 2.1 Level AA compliance achieved
- [ ] Color contrast ratio ≥ 4.5:1 for text and buttons
- [ ] All interactive elements have appropriate ARIA labels
- [ ] Keyboard navigation fully supported
- [ ] Screen reader announces slide changes and current position

#### 3.8 Responsiveness
- [ ] Carousel displays correctly on mobile devices (320px+)
- [ ] Carousel displays correctly on tablets (768px+)
- [ ] Carousel displays correctly on desktop (1024px+)
- [ ] Touch gestures supported on mobile (swipe left/right - optional)

### Testing Requirements

#### 3.9 Manual Testing
- [ ] Test navigation with mouse clicks
- [ ] Test navigation with keyboard arrow keys
- [ ] Test indicator dot selection
- [ ] Test looping behavior at carousel boundaries
- [ ] Test auto-play pause/resume (if implemented)
- [ ] Verify smooth transitions across all browsers

#### 3.10 Accessibility Testing
- [ ] Test with screen reader (NVDA/JAWS/VoiceOver)
- [ ] Verify keyboard navigation completeness
- [ ] Validate color contrast with accessibility tools
- [ ] Test focus states visibility

#### 3.11 Responsive Testing
- [ ] Test on mobile devices (iOS Safari, Chrome)
- [ ] Test on tablets (iPad, Android)
- [ ] Test on desktop at various resolutions
- [ ] Verify layout integrity at breakpoints

---

## 4. Subtasks

### Development Phase
- [ ] Design carousel HTML structure and markup
- [ ] Implement carousel CSS styling and transitions
- [ ] Develop JavaScript carousel logic (slide navigation)
- [ ] Implement indicator dots functionality
- [ ] Add auto-play functionality (optional)
- [ ] Add keyboard navigation support
- [ ] Implement responsive design

### Accessibility Phase
- [ ] Add ARIA labels to buttons and dots
- [ ] Add focus management and visible focus states
- [ ] Audit color contrast ratios
- [ ] Test with screen readers
- [ ] Document keyboard shortcuts

### Testing Phase
- [ ] Unit test carousel logic
- [ ] Integration test with homepage
- [ ] Cross-browser testing
- [ ] Accessibility audit with tools (axe, Lighthouse)
- [ ] Manual testing on real devices
- [ ] Performance optimization

### Documentation Phase
- [ ] Document carousel API/props (if component-based)
- [ ] Create usage guide for content team
- [ ] Document maintenance and future enhancements

# Login/Signup Page Feature - Detailed Requirements Document

## 1. Feature Description

### Overview
Implement a login/signup page for the Flutter union_shop storefront application that provides users with an intuitive interface to authenticate or create new accounts. This feature serves as the gateway for user access to personalized shopping experiences, order history, and account management.

### Purpose
- Enable existing users to securely access their accounts
- Provide new users with a straightforward signup process
- Maintain design consistency with the existing storefront UI
- Prepare the foundation for future authentication backend integration

### Scope Boundaries
- **Included**: UI/UX design, widget structure, form state management
- **Excluded**: Backend authentication, API integration, password validation logic, security implementations

---

## 2. User Stories

### User Story 1: Existing User Login
**As an** existing customer
**I want to** log in using my username or email and password
**So that** I can access my account, view order history, and manage my preferences

**Acceptance Criteria:**
- Username/email input field is clearly labeled and has appropriate placeholder text
- Password input field masks the entered characters
- User can toggle password visibility via an icon
- Login button is prominently displayed and functional (UI-ready)
- Form maintains input state during interactions

### User Story 2: New User Signup
**As a** new customer
**I want to** create a new account through a signup form
**So that** I can make purchases and save my preferences

**Acceptance Criteria:**
- Signup mode is accessible via a button or toggle from the login form
- Same input fields (username/email and password) are available in signup mode
- Form transitions smoothly between login and signup modes
- Signup button is clearly distinguished from login button
- Form fields are cleared when switching between modes

### User Story 3: Password Recovery Access
**As a** user who forgot my password
**I want to** see a "Forgot password?" link
**So that** I can initiate a password recovery process

**Acceptance Criteria:**
- "Forgot password?" link is visible below the password input field
- Link is styled consistently with the storefront theme
- Link is clickable (behavior to be implemented in future phase)

### User Story 4: Responsive Design Access
**As a** mobile and desktop user
**I want to** use the login/signup page comfortably on any device
**So that** I have a consistent experience across all screen sizes

**Acceptance Criteria:**
- Layout adapts properly to mobile, tablet, and desktop screen sizes
- Input fields remain usable with appropriate touch targets on mobile
- Spacing and padding are consistent with storefront theme
- App logo/branding is visible and appropriately sized

---

## 3. Acceptance Criteria

### Functional Requirements

#### 3.1 Form Structure & State Management
- [ ] Widget file created: `lib/screens/login_signup_screen.dart`
- [ ] Stateful widget (`LoginSignupScreen`) implemented
- [ ] Form state management using `TextEditingController` for email/username and password fields
- [ ] State variable to track login vs. signup mode
- [ ] State variable to track password visibility toggle
- [ ] State variable to track "Remember me" checkbox status

#### 3.2 UI Components - Login/Signup Mode

**Username/Email Field:**
- [ ] `TextField` widget with placeholder text "Username or Email"
- [ ] Appropriate input type (email keyboard for mobile)
- [ ] Connected to `TextEditingController`
- [ ] Clear visual styling

**Password Field:**
- [ ] `TextField` widget with placeholder text "Password"
- [ ] Password obscuring enabled by default
- [ ] Connected to `TextEditingController`
- [ ] Show/hide password toggle icon (eye icon)
- [ ] Toggle icon updates `obscureText` property dynamically

**Action Buttons:**
- [ ] Login button (primary action in login mode)
- [ ] Signup button (primary action in signup mode)
- [ ] Mode toggle button/link to switch between login and signup
- [ ] Buttons are visually distinct and properly sized

#### 3.3 Optional UI Elements

**Remember Me Checkbox:**
- [ ] Checkbox widget displayed below password field
- [ ] Label text "Remember me" next to checkbox
- [ ] Checkbox state managed in form state
- [ ] Optional (can be included in first iteration or deferred)

**Forgot Password Link:**
- [ ] Clickable link with text "Forgot password?"
- [ ] Positioned below password field or at bottom of form
- [ ] Styled consistently with theme
- [ ] Placeholder for future functionality

**Branding:**
- [ ] App logo or title displayed at top of form
- [ ] Appropriate sizing and spacing
- [ ] Consistent with existing storefront design

#### 3.4 Design & Responsiveness

- [ ] Layout is responsive and works on mobile (360px+), tablet (600px+), and desktop (1000px+)
- [ ] Minimum touch target size of 48x48dp for buttons and interactive elements
- [ ] Consistent padding and margins (using theme spacing values)
- [ ] Colors and typography consistent with storefront theme
- [ ] Form elements properly aligned and centered
- [ ] No horizontal scrolling required on any screen size

#### 3.5 Code Quality

- [ ] Widget follows Flutter best practices and conventions
- [ ] Code is properly commented with documentation
- [ ] Consistent naming conventions for variables and methods
- [ ] No null safety issues or warnings
- [ ] Code is formatted according to project standards
- [ ] Imports are organized and unnecessary imports removed

#### 3.6 Integration Readiness

- [ ] Form state is accessible for future authentication logic implementation
- [ ] `TextEditingController` values can be easily extracted for API calls
- [ ] Widget structure allows for easy addition of validation logic
- [ ] Clear separation between UI and business logic
- [ ] Placeholder methods defined for future functionality (e.g., `_handleLogin()`, `_handleSignup()`)

---

## 4. Subtasks

### Phase 1: Widget Structure
- [ ] Create `LoginSignupScreen` stateful widget file
- [ ] Initialize `TextEditingController` instances for email and password
- [ ] Create state variables for mode toggle, password visibility, and remember me
- [ ] Implement `dispose()` method for controller cleanup

### Phase 2: UI Layout
- [ ] Design main form container with appropriate padding
- [ ] Implement app logo/branding section at top
- [ ] Build email/username input field with controller
- [ ] Build password input field with visibility toggle

### Phase 3: Interactive Elements
- [ ] Implement password show/hide toggle icon with state management
- [ ] Add "Remember me" checkbox (optional)
- [ ] Add "Forgot password?" link (optional)
- [ ] Implement login/signup mode toggle button/link

### Phase 4: Button Implementation
- [ ] Create login button with styling
- [ ] Create signup button with styling
- [ ] Implement mode switching logic between buttons
- [ ] Add form reset when switching modes

### Phase 5: Responsive Design
- [ ] Test layout on mobile screens
- [ ] Test layout on tablet screens
- [ ] Test layout on desktop screens
- [ ] Adjust padding, margins, and spacing for each breakpoint
- [ ] Verify touch target sizes on mobile

### Phase 6: Polish & Documentation
- [ ] Review code for consistency and best practices
- [ ] Add inline comments and documentation
- [ ] Verify all controllers are properly disposed
- [ ] Ensure theme consistency with existing codebase
- [ ] Final testing across all screen sizes

---

## 5. Success Metrics

- All acceptance criteria marked as complete
- No null safety warnings or errors
- Responsive design verified on at least 3 different screen sizes
- Ready for backend integration in next phase