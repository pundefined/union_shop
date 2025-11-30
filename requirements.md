# Union Shop - Requirements

---

## 1. App Shell + Navbar

### Description
Extract the top navigation bar into a reusable component and introduce an application shell that composes the navbar with page content. This centralizes navigation UI, reduces duplication, and ensures consistent behavior and appearance across all routes.

### User Stories
- As a user, I want a consistent top navbar across pages so I can quickly navigate home by tapping the logo.
- As a user, I want tapping the logo to take me home
- As a user, I want the back button to return me to the previous page for standard navigation.
- As a user, I want tappable controls to be easy to tap on touch devices.

### Acceptance Criteria
- [ ] Reusable navbar component with logo and navigation buttons.
- [ ] App shell component accepting child content and optional title, floating action, bottom nav.
- [ ] All routes wrapped by app shell.
- [ ] Named routes resolve correctly; deep links work.
- [ ] Logo tap navigates home and clears navigation history.
- [ ] Product navigation pushes normally; back button pops as expected.
- [ ] Navbar layout matches pre-refactor at mobile/tablet sizes.
- [ ] Tappable controls meet 48x48 logical pixel minimum.
- [ ] Images include semantic labels.
- [ ] Widget tests verify logo presence, tap navigation, and shell wrapping.

### Subtasks
- [ ] Create reusable navbar component.
- [ ] Create app shell component.
- [ ] Update routes to use app shell.
- [ ] Update product page to use shell pattern.
- [ ] Add navbar widget tests.
- [ ] Add shell integration tests.
- [ ] Manual visual verification at mobile/tablet sizes.

---

## 2. About Page

### Description
Add a simple, accessible, responsive "About us" page with organization information, expose a persistent link from the navbar, and ensure the page is reachable via deep link and standard navigation.

### User Stories
- As a user, I want an "About" page explaining what the store is so I can learn about it.
- As a user, I want to open the About page from any screen using the navbar.
- As a user, I want to navigate back from the About page to where I was before.

### Acceptance Criteria
- [ ] About page component displays organization information.
- [ ] Route registered and accessible via deep link.
- [ ] Page shows centered "About us" title using theme headline style.
- [ ] Page contains 4–6 paragraphs; content is scrollable on small screens.
- [ ] Navbar includes "About" link that navigates without clearing history.
- [ ] Back button returns to previous page normally.
- [ ] Widget test verifies title and paragraph presence.

### Subtasks
- [ ] Create About page component.
- [ ] Register About route.
- [ ] Add "About" link to navbar.
- [ ] Add widget test for About page.
- [ ] Manual verification on mobile/tablet.

---

## 3. Collections Page

### Description
Display product collections as an interactive grid of image tiles with overlaid text, allowing users to browse curated groups. The grid is responsive, provides tap feedback, and navigates to collection detail pages.

### User Stories
- As a user, I want to see collections in a grid layout that adapts to my screen size.
- As a user, I want to tap a collection tile and see visual feedback before navigating.
- As a user, I want to see each collection's title overlaid on its image.

### Acceptance Criteria
- [ ] Responsive grid: 2 columns (<600px), 3 columns (600–900px), 4 columns (>900px).
- [ ] Tiles maintain square aspect ratio with consistent padding.
- [ ] Background image covers tile; text overlay has gradient for contrast.
- [ ] Placeholder shown while loading; fallback on error.
- [ ] Tap feedback (ripple); tap triggers navigation to collection detail.
- [ ] 6–8 sample collections with title and image.
- [ ] Collection tile extracted as reusable component.
- [ ] Widget tests verify tile count, tap callback, and responsive columns.

### Subtasks
- [ ] Create collections page component.
- [ ] Create reusable collection tile component.
- [ ] Implement responsive grid logic.
- [ ] Add sample collection data.
- [ ] Add widget tests.

---

## 4. Collection Page (Detail)

### Description
Display a single collection's products in a responsive grid with header (title/description) and placeholder filter/sort controls. Users can tap product cards to view details.

### User Stories
- As a user, I want to view products in an organized grid within a collection.
- As a user, I want to see the collection title and description at the top.
- As a user, I want to tap a product card to view its details.
- As a user, I want to see filter and sort options for future use.

### Acceptance Criteria
- [ ] Page displays collection data (title, description, items).
- [ ] Header shows collection title and description with appropriate spacing.
- [ ] "Filter By" and "Sort By" dropdowns render side-by-side (UI-only).
- [ ] Responsive grid: 2 columns (<600px), 3 columns (≥600px).
- [ ] Product cards show image, name, price; cards have tap feedback.
- [ ] Minimum 44x44dp tap targets; responsive on mobile/tablet/desktop.
- [ ] Reusable components for container, grid item cards, dropdowns.

### Subtasks
- [ ] Create collection detail page component.
- [ ] Create reusable product card component.
- [ ] Create dropdown control components.
- [ ] Implement responsive grid.
- [ ] Add sample product data.

---

## 5. Product Page

### Description
Comprehensive product detail page displaying product info (image, name, price, description), variant selectors (color/size), quantity control, and "Add to Cart" button. Supports navigation back to parent collection.

### User Stories
- As a user, I want to view detailed product information to make informed decisions.
- As a user, I want to select color and size options before adding to cart.
- As a user, I want to specify the quantity I want to purchase.
- As a user, I want to add products to my cart.
- As a user, I want to return to the collection view from the product page.

### Acceptance Criteria
- [ ] Product image displays with placeholder fallback.
- [ ] Name, price, discounted price (if applicable), and description are visible.
- [ ] Color dropdown renders only when colors available; size dropdown only when sizes available.
- [ ] Quantity selector defaults to 1; cannot go below 1.
- [ ] "Add to Cart" button validates quantity > 0 and required selections.
- [ ] "Back to Collection" button navigates to parent collection.
- [ ] Route receives product and collection as parameters.
- [ ] Product model includes description, discounted price, colors, sizes.

### Subtasks
- [ ] Update product model with new fields.
- [ ] Create product page component.
- [ ] Implement image display with placeholder.
- [ ] Implement variant dropdowns and quantity selector.
- [ ] Implement action buttons and navigation.
- [ ] Add widget tests.

---

## 6. Homepage Banner Carousel

### Description
Convert the static homepage banner into an interactive carousel displaying multiple promotional slides with navigation controls (prev/next buttons, indicator dots) and optional auto-play functionality.

### User Stories
- As a user, I want to browse carousel slides using navigation buttons.
- As a user, I want to jump directly to a slide by clicking indicator dots.
- As a user, I want slides to advance automatically so I can passively discover content.

### Acceptance Criteria
- [ ] Carousel displays one full-width slide at a time (image, heading, subtext).
- [ ] Previous/next buttons positioned on left/right sides; always visible.
- [ ] Indicator dots below carousel; active dot visually distinguished; dots are clickable.
- [ ] Smooth transitions; carousel loops at boundaries.
- [ ] Auto-play advances every 5 seconds; pauses on hover; resumes after mouse leaves.
- [ ] Responsive on mobile/tablet/desktop.
- [ ] Keyboard navigation and ARIA labels for accessibility.

### Subtasks
- [ ] Create carousel component structure.
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
- As a user, I want to log in using my credentials to access my account.
- As a user, I want to create a new account through a signup form.
- As a user, I want to see a "Forgot password?" link to recover my account.
- As a user, I want the login/signup page to be usable on any device.

### Acceptance Criteria
- [ ] Login/signup page component with stateful form.
- [ ] Form fields for email/username and password with proper state management.
- [ ] Password field has show/hide toggle icon.
- [ ] Mode toggle switches between login and signup; fields clear on switch.
- [ ] "Remember me" checkbox and "Forgot password?" link present (optional).
- [ ] Login/signup buttons styled and functional (UI-ready).
- [ ] Responsive layout; 48x48dp minimum touch targets.
- [ ] Form state properly cleaned up on dispose.

### Subtasks
- [ ] Create login/signup page component.
- [ ] Implement form fields with state management.
- [ ] Implement password visibility toggle.
- [ ] Implement mode toggle logic.
- [ ] Add optional checkbox and link.
- [ ] Style buttons and ensure responsiveness.

---

## 8. Responsive Navigation Bar with Mobile Menu

### Description
Implement a responsive navbar that displays horizontal links on desktop and a hamburger menu on mobile. Page content shifts to accommodate the expanded mobile menu.

### User Stories
- As a user, I want to access navigation through a hamburger icon on mobile so my screen isn't cluttered.
- As a user, I want to close the mobile menu by tapping the hamburger icon again.
- As a user, I want to see navigation links displayed horizontally on larger screens.

### Acceptance Criteria
- [ ] Screen width detection; layout changes at breakpoint.
- [ ] Hamburger icon visible only on small screens; hidden on desktop.
- [ ] Tapping hamburger toggles menu open/closed
- [ ] Page content animates down/up in sync with menu.
- [ ] Desktop shows horizontal navigation links; no hamburger icon.
- [ ] Existing navbar styling and branding maintained.

### Subtasks
- [ ] Implement responsive breakpoint detection.
- [ ] Create mobile menu container with vertical links.
- [ ] Implement desktop horizontal layout.
- [ ] Integrate menu state toggle.
- [ ] Test on multiple device sizes.

---

## 9. Shopping Cart

### Description
Implement a shopping cart feature that allows users to add products to a cart, view cart contents on a dedicated page, and proceed to checkout. The cart state persists during the session. Checkout is UI-only with no backend integration.

### User Stories
- As a user, I want to add products to my cart so I can purchase them later.
- As a user, I want to view all items in my cart on a dedicated page.
- As a user, I want to see a checkout button so I can proceed to purchase.

### Acceptance Criteria
- [ ] Cart state management stores added items during the session.
- [ ] "Add to Cart" action adds the current product to the cart.
- [ ] Cart page displays list of all items in the cart (image, name, price).
- [ ] Cart page shows total price of all items.
- [ ] Empty cart displays a friendly message with link to continue shopping.
- [ ] Cart icon in navbar shows item count badge; navigates to cart page.
- [ ] "Checkout" button is visible and styled (UI-only; no backend action).
- [ ] Route registered and accessible via deep link.
- [ ] Responsive layout on mobile/tablet/desktop.

### Subtasks
- [ ] Create cart state management (provider/model).
- [ ] Create cart page component.
- [ ] Implement cart item list display.
- [ ] Implement total price calculation.
- [ ] Add cart icon with badge to navbar.
- [ ] Implement "Checkout" button (dummy action).
- [ ] Register cart route.
- [ ] Add widget tests for cart page.

---

## 10. Personalisation - The Print Shack

### Description
Implement "The Print Shack" feature that allows users to configure personalisation on their items with up to 4 printed lines of custom text. This includes a personalisation form page with a dynamic form that updates based on line count selection, and an about page describing the service. Both pages are accessible via a new collapsible navbar section. This is a UI-only feature; personalisation is not implemented as a purchasable product.

### User Stories
- As a user, I want to configure custom text for my items so I can personalise my merchandise.
- As a user, I want to choose how many lines of text (1-4) to add so I have flexibility in my personalisation.
- As a user, I want the form to update dynamically based on my line count selection so I only see relevant fields.
- As a user, I want to learn about the personalisation service on a dedicated about page.
- As a user, I want to access Print Shack pages from a dedicated section in the navbar.

### Acceptance Criteria
- [ ] Personalisation form page displays with dynamic text input fields (1-4 lines).
- [ ] Line count selector updates the number of visible text input fields in real-time.
- [ ] Text input fields have appropriate labels and character limits.
- [ ] Submit button triggers placeholder action (snackbar/dialog).
- [ ] Print Shack about page displays service description, guidelines, and pricing info.
- [ ] Navbar includes collapsible "The Print Shack" section with sub-items.
- [ ] Desktop navbar shows dropdown menu; mobile menu shows expandable section.
- [ ] Routes registered: `/print-shack` (form) and `/print-shack/about`.
- [ ] Pages use consistent layout structure with product pages (refactor if needed).
- [ ] Responsive layout on mobile/tablet/desktop.
- [ ] Minimum 48x48dp tap targets; proper accessibility labels on form fields.

### Subtasks
- [ ] Create personalisation form page component.
- [ ] Implement dynamic form with line count selector.
- [ ] Implement text input fields with validation.
- [ ] Create Print Shack about page component.
- [ ] Add collapsible "The Print Shack" section to navbar.
- [ ] Implement navbar expand/collapse behaviour for mobile and desktop.
- [ ] Register routes for both pages.
- [ ] Refactor shared page layout from product page (if applicable).
- [ ] Add widget tests for form page and about page.

---

## 11. Checkout Screen

### Description
Implement a checkout screen that displays an order summary before purchase. Users navigate to checkout from the cart page, review their order, and place the order. Order placement is UI-only with dummy behaviour that shows a confirmation SnackBar and navigates back to the home page.

### User Stories
- As a user, I want to review my order before placing it so I can confirm my selections.
- As a user, I want to see all items in my order with their details and prices.
- As a user, I want to place my order and receive confirmation that it was successful.
- As a user, I want to return to the home page after placing my order.

### Acceptance Criteria
- [ ] Checkout page displays order summary with all cart items.
- [ ] Each item shows image, name, variants (if applicable), quantity, and price.
- [ ] Price breakdown shows subtotal and total prominently.
- [ ] "Place Order" button is visible and styled consistently with app design.
- [ ] Tapping "Place Order" displays a SnackBar confirming order placement.
- [ ] After order placement, cart is cleared and user navigates to home.
- [ ] Route registered (`/checkout`) and accessible via navigation from cart.
- [ ] Back navigation returns to cart page for order modifications.
- [ ] Responsive layout on mobile/tablet/desktop.
- [ ] Minimum 48x48dp tap targets.

### Subtasks
- [ ] Create checkout page component.
- [ ] Implement order summary display with item details.
- [ ] Implement price breakdown and total calculation.
- [ ] Implement "Place Order" button with SnackBar and navigation.
- [ ] Update cart page checkout button to navigate to checkout.
- [ ] Register checkout route.
- [ ] Add widget tests for checkout page.