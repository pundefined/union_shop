# Shopping Cart Feature Implementation

## Goal
Implement a shopping cart feature that allows users to add products to a cart, view cart contents on a dedicated page, and see a checkout button. Cart state persists during the session. Checkout is UI-only with no backend integration.

## Feature Description

### Cart State Management
- **Session-based cart**: Cart state persists during app session
- **Add to cart**: Products can be added from the product page
- **Cart model**: Store product reference and relevant details (image, name, price)

### Cart Page Layout
- **Item list**: Display all items currently in the cart
  - Product image (thumbnail)
  - Product name
  - Product price
- **Total section**: Display calculated total price of all items
- **Empty state**: Friendly message when cart is empty with link to continue shopping
- **Checkout button**: Prominently styled button (dummy action for now)

### Navbar Integration
- **Cart icon**: Add cart icon to navbar
- **Badge**: Show item count on cart icon when items are present
- **Navigation**: Tapping cart icon navigates to cart page

## Implementation Details

### Widgets/Files to Create
1. **Cart Model** (`/lib/models/cart.dart`):
   - Cart item class to store product details
   - Cart class/provider to manage list of items
   - Method to add item
   - Method to calculate total price
   - Getter for item count

2. **Cart Page** (`/lib/screens/cart_page.dart`):
   - Displays list of cart items
   - Shows total price
   - Empty state with continue shopping link
   - Checkout button (UI-only)

3. **Navbar Updates**:
   - Cart icon with badge showing item count
   - Navigation to cart page on tap

### Technical Requirements
- Use appropriate state management (Provider, InheritedWidget, or simple stateful approach)
- **ListView.builder** for cart item list
- Responsive layout for mobile/tablet/desktop
- Register `/cart` route for deep linking
- Minimum 48x48dp tap targets

### Content
- Cart items sourced from products added via "Add to Cart" button
- Checkout button displays snackbar or dialog placeholder on tap

## Deliverables
1. Cart model/state management file
2. Cart page widget file
3. Updated navbar with cart icon and badge
4. Route registration for cart page
5. Widget tests for cart page

## Notes
- No quantity management in this phase (handled separately)
- No item removal in this phase (handled separately)
- Checkout is UI-only; no payment or backend integration
- Focus on core add-to-cart flow and cart viewing experience
