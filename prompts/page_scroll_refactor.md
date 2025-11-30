# Page Scroll Refactor

## Problem

The current `AppShell` widget handles scrolling for all pages by wrapping content in a `SingleChildScrollView`. This creates several issues:

1. **Nested scroll views** — Pages like `CollectionPage` have their own `SingleChildScrollView`, causing scroll conflicts
2. **Testing complexity** — Tests that wrap pages directly in `Scaffold` don't reflect production behavior where `AppShell` adds its own scroll view
3. **Inflexibility** — Different pages may need different scroll strategies (e.g., `CustomScrollView` with slivers, `ListView.builder`, or no scrolling)

## Solution

Move scroll responsibility from `AppShell` to individual pages, while keeping the navbar/footer pattern DRY.

### Changes

1. **Update `AppShell`** — Remove the `SingleChildScrollView` wrapper. The shell now only provides:
   - The navbar (optional)
   - An `Expanded` area for page content
   - Scaffold features (FAB, bottom nav)

2. **Create `PageContent` widget** — A helper widget that pages can use to get consistent scroll behavior with the footer automatically appended. Supports both regular children and sliver-based layouts.

3. **Update all pages** — Each page now controls its own scrolling using `PageContent` (or custom scroll logic if needed).

### Benefits

- **Cleaner testing** — Pages are self-contained; tests match production behavior
- **No nested scrolling bugs** — Each page has exactly one scroll controller
- **Flexibility** — Pages can choose their scroll strategy
- **Still DRY** — Footer is automatically included via `PageContent`, no manual repetition

### New Architecture

```
AppShell
├── AppNavbar (conditional)
└── Expanded
    └── [Page Content - each page owns its scroll]
        └── PageContent (helper widget)
            ├── Page-specific content
            └── AppFooter (automatic)
```
