# App Shell + Navbar refactor prompt

## Summary
We want to refactor the Flutter storefront so that the top navigation bar (navbar) is defined once and shared across all pages. This reduces duplication, enforces consistent navigation, and makes future changes to the navbar trivial.

---

## Prompt

You are refactoring a Flutter app to introduce an app shell that centralizes the top navigation bar. Please perform the refactor described here.

1) Feature goal
- Extract the existing navbar UI and behavior (from `lib/main.dart`) into a reusable widget (e.g., `AppNavbar`).
- Create an `AppShell` widget that composes the shared navbar plus the page body. `AppShell` should accept a `Widget child` (the page content) and optional parameters (e.g., `title`, `floatingAction`, `bottomNav`) if needed.
- Update routes/pages to use the shell so the navbar is no longer manually duplicated in each page.

2) Contracts (inputs / outputs / success criteria)
- Inputs:
  - The repository source as-is, notably `lib/main.dart` (the current navbar and homepage are defined here) and `lib/product_page.dart` (product page).
  - Existing named routes (currently: `'/'` and `'/product'`).
- Outputs:
  - New files: `lib/widgets/app_navbar.dart` (or similar) and `lib/widgets/app_shell.dart`.
  - Updated `lib/main.dart` to register routes that return `AppShell(child: <page>)` or updated pages that are themselves wrapped in `AppShell`.
  - Unit/widget tests covering the navbar and one route wrapped in `AppShell`.
  - A short migration note listing what changed and how to use the shell.
- Success criteria:
  - App compiles and runs without changing the visible behavior of the navbar.
  - Navigation flows (logo -> home, product tiles -> product page, browse products button -> product page) still work.
  - Navbar UI is visually identical (or extremely close) at common breakpoints.

3) Expected user actions and exact behaviors to preserve
- Tapping the logo (the image in the top-left) navigates to the home route (`'/'`) and clears history (the existing `navigateToHome` uses `pushNamedAndRemoveUntil` behavior). Keep equivalent behavior.
- Do NOT change `placeholderCallbackForButtons` handlers for any buttons that already have them. They are not your concern.
- Image `errorBuilder` behavior should be preserved.

4) Edge cases & accessibility
- Deep linking: ensure existing named routes still work and that wrapping with the shell doesn't break deep links.
- Back navigation: when logo clears history, preserve that behavior. For normal pushes, default back behavior should be unchanged.
- Responsive behavior: preserve the current logic that changes grid columns depending on `MediaQuery.of(context).size.width`.
- Accessibility: keep semantics (e.g., images should have semantic labels when reasonable). Ensure tappable areas meet minimal size guidelines (>= 48x48 logical px for icon buttons).

5) Testing checklist / PR checklist
- [ ] App builds and runs.
- [ ] Navbar UI matches current app at common viewport sizes.
- [ ] Logo tap navigates to home with history cleared.
- [ ] Added at least one widget test to cover the navbar and one navigation action.
