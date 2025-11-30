/// Generates a URL-safe slug from a string.
///
/// Converts to lowercase, replaces spaces and special characters with hyphens,
/// removes consecutive hyphens, and trims hyphens from start/end.
String generateSlug(String input) {
  return input
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9\s-]'), '') // Remove special characters
      .replaceAll(RegExp(r'\s+'), '-') // Replace spaces with hyphens
      .replaceAll(RegExp(r'-+'), '-') // Remove consecutive hyphens
      .replaceAll(RegExp(r'^-|-$'), ''); // Trim hyphens from start/end
}
