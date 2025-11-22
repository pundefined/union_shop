# Add an "About us" page to Flutter storefront and wire it into the navbar

Feature summary
- Add a new About page (route "/about") with placeholder content and styling similar to the provided screenshot.
- Expose a link to this page from the app navbar (AppBar actions or primary navigation component) so users can open it from any top-level screen.
- Keep the page responsive, accessible, and scrollable on small screens.

Requirements / acceptance criteria
1. New widget `AboutPage` (StatelessWidget) that:
   - Shows a centered title "About us" (prominent, using theme headline style).
   - Displays 4–6 short paragraphs of placeholder text (see example below).
   - The content area should be horizontally centered and have comfortable vertical spacing.
   - Use `Theme.of(context).textTheme` if applicable for fonts and sizes; respect dark mode.
   - Include semantic labels for accessibility where applicable.

2. Routing and navigation:
   - Add a named route `/about` to the app's routing configuration.
   - Add an item in the app's navbar labeled "About" which pushes the `/about` route.
   - The navigation item should be visible across main pages in the app.

3. Tests:
   - A widget test that pumps the app and navigates to `/about` and asserts the title and at least one paragraph text are present.
   - Optionally a golden or layout test to verify responsiveness.

Example placeholder text (use as content)
- Title: About us
- Paragraphs:
  1. "Welcome to the Union Shop!"
  2. "We’re dedicated to giving you the very best University branded products, with a range of clothing and merchandise available to shop all year round! We even offer an exclusive personalisation service!"
  3. "All online purchases are available for delivery or instore collection!"
  4. "We hope you enjoy our products as much as we enjoy offering them to you. If you have any questions or comments, please don’t hesitate to contact us at hello@example.org"
  5. "Happy shopping!"
