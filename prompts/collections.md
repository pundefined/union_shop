# Collections Page — Clickable Image Grid with Overlay Text

## Goal
Implement a Collections page in Flutter that displays a grid of clickable image tiles. Each tile shows a background image with centered, readable text overlaid on top. Tiles are tappable (callback/navigation to be wired later). Content is hardcoded for now; data models will be added in a future task.

## Feature Description

### Layout & Responsiveness
- **Grid layout** that adapts to screen width:
  - Small screens (<600px): 2 columns
  - Medium screens (600–900px): 3 columns
  - Large screens (>900px): 4 columns
- **Tile aspect ratio**: Square or 3:4 (configurable)
- **Spacing**: Consistent padding/margins between tiles

### Tile Design
- **Background image**: Network or asset image, cover fit to fill tile
- **Text overlay**: Centered title (and optional subtitle/description)
- **Contrast**: Semi-opaque gradient or dark overlay behind text to ensure readability
- **Visual polish**: Rounded corners, subtle shadow, smooth appearance
- **Tap feedback**: Ripple/ink effect on tap (Material InkWell)
- **Loading state**: Placeholder image or shimmer while loading
- **Error state**: Fallback placeholder if image fails to load

### Interactivity
- Tappable tiles with visual feedback (ripple)
- Per-tile callback (onTap) or route navigation (to be implemented later)
- Keyboard accessible: tiles focusable and activatable via Enter/Space
- Screen reader support via Semantics (e.g., "Open collection: Collection Name")

### Content (Hardcoded)
For this phase, provide 6–8 sample collections with:
- Title (e.g., "Summer Sale", "New Arrivals", "Clearance")
- Placeholder or sample image URL
- Optional description or subtitle

## Implementation Details

### Widgets to Create
1. **CollectionsPage** (or CollectionsGrid): Main page/widget
   - Displays grid of collection tiles
   - Accepts onTap callback (to be wired later)
   - Responsive column count based on screen size
2. **CollectionTile** (sub-widget): Single tile
   - Renders image with text overlay
   - Handles tap and provides visual feedback
   - Accessible and keyboard-friendly

### Technical Requirements
- Use **GridView.builder** with responsive column count via LayoutBuilder or MediaQuery
- Stack widget to layer: image → overlay → text
- **FadeInImage** or similar for loading/error states
- **InkWell** inside Material for ripple tap feedback
- Keep widgets **reusable and well-commented**

## Deliverables
1. A complete, self-contained Dart file with:
   - CollectionsPage widget
   - CollectionTile sub-widget
   - Hardcoded sample collection data (list of maps or simple objects)
2. A simple widget test file demonstrating:
   - Grid renders correct number of tiles
   - Tap triggers expected behavior
   - Responsive columns at different screen widths

## Acceptance Criteria
- ✓ Grid displays all hardcoded collections
- ✓ Titles are readable against all sample images
- ✓ Placeholder shows during image load; error fallback if load fails
- ✓ Column count changes correctly on different screen sizes
- ✓ Keyboard navigation and activation work

## Notes
- Hardcode content for now; data model refactoring is a separate task
- onTap callbacks should be wired up later (for now, can log or show debug toast)
- Prioritize clarity and maintainability over complexity