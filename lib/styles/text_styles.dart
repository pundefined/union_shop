import 'package:flutter/material.dart';

/// Central repository for all text styling across the Union Shop app.
/// This ensures consistent typography and makes it easy to maintain design changes.
class TextStyles {
  // Prevent instantiation
  TextStyles._();

  // ============================================================================
  // HEADING STYLES
  // ============================================================================

  /// Hero title style - Large, bold, white text for hero sections
  static const TextStyle heroTitle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    height: 1.2,
  );

  /// Hero subtitle style - Slightly smaller white text for hero sections
  static const TextStyle heroSubtitle = TextStyle(
    fontSize: 20,
    color: Colors.white,
    height: 1.5,
  );

  /// Large section heading - Bold black text
  static const TextStyle sectionHeading = TextStyle(
    fontSize: 20,
    color: Colors.black,
    letterSpacing: 1,
  );

  /// Product page heading - Large, bold, black text
  static const TextStyle productHeading = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  /// Collection tile title - Bold white text for overlays
  static const TextStyle collectionTileTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    height: 1.2,
  );

  /// Subheading for sections - Medium weight, smaller than main heading
  static const TextStyle subHeading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  /// About page heading - Subheading style for "About us"
  static const TextStyle aboutPageHeading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  /// Collection page heading - Bold headline for collection titles
  static const TextStyle collectionPageHeading = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  /// Collection page description - Secondary text for collection descriptions
  static const TextStyle collectionPageDescription = TextStyle(
    fontSize: 14,
    color: Colors.grey,
    height: 1.5,
  );

  // ============================================================================
  // BODY TEXT STYLES
  // ============================================================================

  /// Primary body text - Standard paragraph text
  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    color: Colors.grey,
    height: 1.5,
  );

  /// Secondary body text - Smaller paragraph text
  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    color: Colors.grey,
    height: 1.5,
  );

  // ============================================================================
  // PRODUCT & CARD STYLES
  // ============================================================================

  /// Product card title - Medium weight, small size
  static const TextStyle productCardTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  /// Product price style - Bold, primary brand color
  static const TextStyle productPrice = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Color(0xFF4d2963),
  );

  /// Strikethrough price style - Discounted original price
  static TextStyle strikethroughPrice = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
    decoration: TextDecoration.lineThrough,
  );

  // ============================================================================
  // BUTTON STYLES
  // ============================================================================

  /// Button text style - Small caps with letter spacing
  static const TextStyle buttonText = TextStyle(
    fontSize: 14,
    letterSpacing: 1,
  );

  // ============================================================================
  // FOOTER STYLES
  // ============================================================================

  /// Footer link style - Blue, medium weight
  static TextStyle footerLink = const TextStyle(
    color: Colors.blue,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  /// Footer plain text - Standard footer text
  static TextStyle footerPlain = TextStyle(
    color: Colors.grey[800],
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  /// Footer italic text - Emphasizes information
  static TextStyle footerItalic = TextStyle(
    color: Colors.grey[800],
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.italic,
  );

  /// Footer heading - Bold, larger text for sections
  static TextStyle footerHeading = TextStyle(
    color: Colors.grey[800],
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  // ============================================================================
  // TOP BANNER STYLE
  // ============================================================================

  /// Top banner announcement text
  static const TextStyle bannerText = TextStyle(
    color: Colors.white,
    fontSize: 16,
  );

  // ============================================================================
  // HELPER METHOD FOR DYNAMIC STYLES
  // ============================================================================

  /// Creates a discounted price style (strikethrough) based on existence
  static TextStyle getPriceStyle({required bool isDiscounted}) {
    if (isDiscounted) {
      return strikethroughPrice;
    } else {
      return productPrice;
    }
  }
}
