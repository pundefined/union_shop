# The Print Shack Feature Implementation

## Goal
Implement "The Print Shack" feature that allows users to configure personalisation on their items with up to 4 printed lines of text. This includes a personalisation form page and an about page describing the service. Both pages will be accessible via a new collapsible navbar item.

## Feature Description

### Personalisation Form Page
- **Dynamic form**: Form updates dynamically based on the number of lines selected (1-4)
- **Line count selector**: Dropdown or segmented control to choose number of lines (1-4)
- **Text input fields**: Text fields appear/disappear based on selected line count
- **Character limit**: Enforce reasonable character limits per line

### Print Shack About Page
- **Service description**: Explain the personalisation service offering
- **Process overview**: Brief description of how personalisation works
- **Guidelines**: Character limits, available fonts/styles, turnaround time
- **Pricing info**: Placeholder pricing for the service

### Navbar Integration
- **New collapsible item**: Add "The Print Shack" as a collapsible/expandable navbar section
- **Sub-items**: 
  - "Personalise Your Item" → Links to personalisation form
  - "About Print Shack" → Links to about page
- **Desktop**: Dropdown menu on hover/click
- **Mobile**: Expandable section in mobile menu

## Implementation Details

### Widgets/Files to Create
1. **Personalisation Form Page** (`/lib/screens/print_shack_form_page.dart`):
   - Line count selector (1-4 lines)
   - Dynamic text input fields based on 
   - Submit button (UI-only, placeholder action)
   - Use same layout structure as product pages

2. **Print Shack About Page** (`/lib/screens/print_shack_about_page.dart`):
   - Title: "The Print Shack"
   - Description of personalisation service
   - Guidelines and pricing information
   - Styling consistent with existing about page

3. **Navbar Updates** (`/lib/widgets/app_navbar.dart`):
   - Add collapsible "The Print Shack" section
   - Include sub-navigation items for form and about pages
   - Handle expand/collapse state
   - Responsive behaviour for mobile/desktop

4. **Shared Layout Refactor** (if needed):
   - Extract common layout structure from product pages
   - Create reusable page layout widget for consistency
   - Apply to personalisation form page

### Technical Requirements
- **Dynamic form**: Use `setState` or appropriate state management to show/hide text fields
- **Form validation**: Validate text inputs (non-empty, character limits)
- **Responsive layout**: Mobile/tablet/desktop support
- **Route registration**: Register `/print-shack` and `/print-shack/about` routes
- **Minimum 48x48dp tap targets**
- **Accessibility**: Proper labels for form fields and interactive elements

### Content

#### Personalisation Form
- Title: "Personalise Your Item"
- Subtitle: "Add up to 4 lines of custom text"
- Line count options: 1, 2, 3, 4
- Placeholder text for inputs: "Enter line 1", "Enter line 2", etc.
- Submit action: Display snackbar or dialog placeholder

#### Print Shack About Page
- Title: "The Print Shack"
- Content paragraphs:
  1. "Welcome to The Print Shack – your one-stop destination for personalised University merchandise!"
  2. "Make your items truly unique with our custom text printing service. Whether it's your name, a special date, or a meaningful phrase – we've got you covered."
  3. "Our personalisation service allows up to 4 lines of text on selected items. Each line can contain up to 20 characters."
  4. "Personalised items are typically ready within 3-5 working days. Please note that personalised items cannot be returned or exchanged."
  5. "For any questions about our personalisation service, please contact us at printshack@example.org"

## Deliverables
1. Personalisation form page widget file
2. Print Shack about page widget file
3. Updated navbar with collapsible "The Print Shack" section
4. Route registration for both pages
5. Refactored shared layout (if applicable)
6. Widget tests for both pages

## Notes
- This is a UI-only feature; no backend integration required
- Personalisation is NOT implemented as a product or purchasable item
- Focus on dynamic form behaviour and consistent page structure
- Consider extracting product page layout for reuse
