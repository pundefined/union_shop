# Responsive Navigation Bar with Mobile Menu

## Feature Description

Implement a responsive navigation bar that adapts based on device width:

### Mobile Layout (Small Widths)
- Display a hamburger menu icon in the navbar
- When tapped, the menu icon triggers a slide-down animation
- Navigation links appear in a vertical list below the navbar
- Page content is pushed down to accommodate the expanded menu
- Tapping the menu icon again collapses the menu and slides content back up

### Desktop Layout (Wide Widths)
- Hide the hamburger menu icon
- Display navigation links horizontally in the navbar
- Page content remains in its normal position

### Technical Requirements
- Use MediaQuery to detect screen width breakpoints
- Implement smooth animations for menu expansion/collapse
- Apply responsive widget layout (e.g., Row/Column based on screen size)
- Ensure menu state is managed (open/closed)
- Maintain the existing navbar styling and branding