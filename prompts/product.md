## Product Page Feature Implementation

### Overview
Implement a product detail page in Flutter that displays comprehensive product information and allows users to configure and add items to their cart.

### Data Model Updates
The existing `Product` model in `/lib/models/product.dart` needs to be extended with:
- `description` (String): Product description
- `discountedPrice` (double, optional): Discounted price if applicable
- `colors` (List<String>, optional): Available color options
- `sizes` (List<String>, optional): Available size options

### UI Components Required
1. **Product Image**: Display product image with placeholder support
2. **Product Info Section**:
   - Product name (heading)
   - Price (required)
   - Discounted price (optional, displayed if available)
   - Description text
3. **Selection Dropdowns** (optional fields):
   - Color selector dropdown (only shown if colors list is not empty)
   - Size selector dropdown (only shown if sizes list is not empty)
4. **Quantity Selector**: Spinner/number input for quantity (mandatory, minimum 1)
5. **Action Buttons**:
   - "Add to Cart" button (placeholder implementation)
   - "Back to Collection" button (navigates back to parent collection)

### Navigation
- The page should receive both the product and its parent `Collection` as route parameters
- The "Back to Collection" button should navigate back to the collection view

### State Management
- Track selected color, size, and quantity in the page state
- Validate that fields are set before allowing cart addition
- Do not add to cart if quantity is 0