# Deep Linking with URL-Based Routing

## Goal
Implement deep linking with human-readable, hierarchical URLs so that collections and products are directly accessible via URL paths. This enables bookmarking, sharing, and SEO-friendly navigation.

## Feature Description

### URL Structure
- **Collections list**: `/collections`
- **Single collection**: `/collections/{collection-slug}` (e.g., `/collections/new-arrivals`)
- **Product within collection**: `/collections/{collection-slug}/products/{product-slug}` (e.g., `/collections/new-arrivals/products/rainbow-lanyard`)

### Slug Generation
- Slugs are URL-safe identifiers derived from display names
- Convert to lowercase, replace spaces with hyphens, remove special characters
- Examples:
  - "New Arrivals" → `new-arrivals`
  - "Rainbow Lanyard" → `rainbow-lanyard`
  - "Summer Sale 2025!" → `summer-sale-2025`

### Routing Requirements
1. **Path-based routing**: Replace argument-based navigation with URL path parameters
2. **Slug resolution**: Look up collections and products by their slug
3. **Fallback handling**: Show 404 or redirect to collections if slug not found
4. **Backward compatibility**: Existing navigation flows continue to work
5. **Browser integration**: URLs update in browser address bar; back/forward buttons work correctly

### Data Model Updates
- Add `slug` field to `Collection` model (auto-generated from name or explicitly set)
- Add `slug` field to `Product` model (auto-generated from name or explicitly set)
- Implement slug lookup methods for both models

### Navigation Updates
- Update all `Navigator.pushNamed` calls to use path-based routes
- Collection tiles navigate to `/collections/{slug}` instead of passing objects
- Product cards navigate to `/collections/{collection-slug}/products/{product-slug}`
- "Back to Collection" uses path-based navigation

### Technical Implementation
- Use `onGenerateRoute` to parse URL paths and extract slugs
- Consider using a routing package (e.g., `go_router`) for cleaner path parameter handling
- Ensure routes work with Flutter web's URL strategy
- Support direct URL entry in browser

## Implementation Details

### Route Parsing
Parse incoming routes to extract path segments:
```
/collections → CollectionsPage
/collections/{collection-slug} → CollectionPage(collection)
/collections/{collection-slug}/products/{product-slug} → ProductPage(product)
```

### Slug Utilities
Create utility functions:
- `String generateSlug(String name)` — Convert display name to URL slug
- `Collection? findCollectionBySlug(String slug)` — Look up collection
- `Product? findProductBySlug(String slug, Collection collection)` — Look up product within collection

### Error Handling
- Invalid collection slug → Show "Collection not found" or redirect to `/collections`
- Invalid product slug → Show "Product not found" or redirect to collection page
- Malformed URLs → Redirect to home or show 404

## Deliverables
1. Updated `Collection` model with `slug` field and lookup method
2. Updated `Product` model with `slug` field and lookup method
3. Slug generation utility function
4. Updated routing configuration with path parameter support
5. Updated navigation calls throughout the app
6. Error/404 handling for invalid slugs
7. Widget tests verifying:
   - Slug generation produces expected results
   - Route parsing extracts correct slugs
   - Navigation to `/collections/{slug}` loads correct collection
   - Navigation to `/collections/{slug}/products/{slug}` loads correct product
   - Invalid slugs handled gracefully

## Acceptance Criteria
- ✓ Entering `/collections/new-arrivals` in browser loads the "New Arrivals" collection
- ✓ Entering `/collections/new-arrivals/products/rainbow-lanyard` loads the product page
- ✓ Clicking a collection tile updates URL to `/collections/{slug}`
- ✓ Clicking a product card updates URL to full product path
- ✓ Browser back/forward buttons navigate correctly
- ✓ Sharing a URL allows another user to view the same page
- ✓ Invalid slugs show appropriate error or redirect
- ✓ All existing navigation flows continue to work

## Notes
- Use `go_router` package for cleaner declarative routing
- Ensure Flutter web URL strategy is configured (path-based, not hash-based)
- Slugs should be generated consistently to avoid lookup mismatches
- For products with same name in different collections, the collection context disambiguates
