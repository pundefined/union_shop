# Search Feature Implementation

## Goal
Implement a search feature that allows users to search for products by name or description. The feature includes a search overlay in the navbar and a dedicated search page, both displaying matching products with their prices.

## Feature Description

### Navbar Search Overlay
- **Search icon**: Tappable search icon in the navbar
- **Overlay behaviour**: Tapping the icon opens a search bar that overlays the navbar
- **Search input**: Text field for entering search terms
- **Close button**: Button to dismiss the search overlay
- **Submit action**: Submitting the search navigates to `/search?q={term}` with the search term pre-entered

### Search Page
- **Route**: Accessible at `/search` via footer link or navbar search submission
- **Search input**: Text field for entering or modifying search terms
- **Results display**: List/grid of products matching the search term
- **Product cards**: Each result shows product image, name, description excerpt, and price
- **Empty state**: Message when no results are found

### Search Logic
- **Search scope**: Match search term against product name and description (case-insensitive)
- **URL sync**: Search term is reflected in the URL query parameter (`/search?q={term}`)

## Implementation Details

### Widgets/Files to Create
1. **Search Page** (`/lib/screens/search_page.dart`):
   - Text input for search term
   - Results grid/list displaying matching products
   - Empty state and no-results state
   - Product cards with image, name, description excerpt, and price

2. **Search Overlay Component** (`/lib/widgets/search_overlay.dart` or integrated in navbar):
   - Animated overlay that appears over the navbar
   - Text input field with search icon
   - Close button to dismiss
   - Submit handler that navigates to search page

3. **Search Utility** (`/lib/utils/search_utils.dart`):
   - Function to filter products by search term
   - Case-insensitive matching on name and description

### Navigation Updates
- **Navbar**: Add search icon that toggles the search overlay
- **Footer**: Add "Search" link that navigates to `/search`
- **Router**: Register `/search` route with optional `q` query parameter

### Technical Requirements
- Use `go_router` query parameters for search term (`/search?q={term}`)
- Implement debounce (300-500ms) for real-time search
- Responsive layout for mobile/tablet/desktop
- Minimum 48x48dp tap targets
- Search overlay animates smoothly (slide down or fade in)
- Keyboard support: Enter key submits search in overlay

### Content
- Search results sourced from existing product data
- Product cards reuse existing product card component where applicable
- Results show: image thumbnail, product name, price (and discounted price if applicable)

## Deliverables
1. Search page widget file
2. Search overlay component (or navbar updates)
3. Search utility functions
4. Route registration for search page
5. Footer link to search page
6. Widget tests for search page and overlay

## Notes
- Search is client-side only; no backend integration
- Consider performance with large product lists (debounce, limit displayed results)
- Search overlay should close when navigating away
- URL query parameter enables sharing search results via link
