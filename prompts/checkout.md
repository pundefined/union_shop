# Checkout Screen Implementation

## Goal
Implement a checkout screen that displays an order summary and allows users to place an order. The checkout page is accessed from the cart page and provides a clear overview of what will be purchased before order confirmation.

## Feature Description

### Order Summary
- **Item list**: Display all cart items with relevant details
  - Product image (thumbnail)
  - Product name
  - Selected variants (color, size) if applicable
  - Quantity
  - Line item price
- **Price breakdown**: Show subtotal of all items
- **Total section**: Display final order total prominently

### Place Order Action
- **Place Order button**: Prominently styled button at the bottom
- **Dummy behaviour**: On tap, display a SnackBar confirming order placement
- **Navigation**: After placing order, navigate back to home and clear cart

### Navigation
- **Entry point**: Navigate to checkout from cart page "Checkout" button
- **Back navigation**: Allow users to return to cart to make changes

## Implementation Details

### Widgets/Files to Create
1. **Checkout Page** (`/lib/screens/checkout_page.dart`):
   - Displays order summary with all cart items
   - Shows price breakdown and total
   - "Place Order" button with dummy action
   - Scrollable layout for long item lists

### Technical Requirements
- Register `/checkout` route for deep linking
- Access cart state to display items and calculate totals
- Clear cart after successful order placement
- Navigate to home page after order placement
- Responsive layout for mobile/tablet/desktop
- Minimum 48x48dp tap targets

### UI Layout
- Centered content with max width constraint (consistent with cart page)
- "Order Summary" heading at top
- List of cart items with details
- Divider between items section and totals
- Subtotal and total clearly displayed
- "Place Order" button full-width at bottom
- Optional: "Back to Cart" link or rely on app bar back button

### Content
- Cart items sourced from cart provider
- SnackBar message: "Order placed successfully!" or similar

## Deliverables
1. Checkout page widget file
2. Updated cart page to navigate to checkout
3. Route registration for checkout page
4. Widget tests for checkout page

## Notes
- No payment integration; this is UI-only
- No shipping/billing address forms in this phase
- Cart should be cleared after placing order
- Focus on clean order summary presentation
