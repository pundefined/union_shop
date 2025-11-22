## Feature: Collection Page in Flutter Storefront

### Overview
Create a new collection page that displays a curated collection of items in a grid layout with filtering and sorting options.

### Page Layout (Top to Bottom)
1. **Header Section**
   - Collection title
   - Short description text below the title

2. **Control Section**
   - Two dropdown controls side-by-side:
     - "Filter By" dropdown (e.g., product category)
     - "Sort By" dropdown (e.g., newest, price low-to-high, alphabetical)
   - Note: Dropdowns are UI-only for now; functionality will be implemented separately

3. **Items Grid**
   - Display items in a responsive grid layout (2-3 columns depending on screen size)
   - Each grid item should be clickable and display:
     - Product image (top)
     - Product name (below image)
     - Price (below name)
   - Items should have proper spacing and padding

### Data & Implementation
- Hardcode sample collection data (title, description, item list)
- Hardcode sample item data (name, price, image URL/asset)
- Create reusable widgets for:
  - Collection page container
  - Individual grid item card
  - Dropdown controls

### UI/UX Considerations
- Maintain consistent styling with existing storefront design
- Ensure grid items are tap-friendly
- Add loading states or placeholder images where appropriate
- Make the layout responsive for different screen sizes