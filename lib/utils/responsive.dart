import 'package:flutter/material.dart';

/// Centralized responsive breakpoints for consistent layout across the app.
class Breakpoints {
  Breakpoints._();

  /// Mobile breakpoint - screens narrower than this use mobile layout
  /// Set to 820px to ensure desktop navbar has enough room for all links
  static const double mobile = 820.0;
}

/// Enumeration for screen size categories used throughout the app.
enum ScreenSize { mobile, desktop }

/// Utility class for responsive layout helpers.
class Responsive {
  Responsive._();

  /// Determines the screen size category based on width.
  ///
  /// - [ScreenSize.mobile]: width < 600px
  /// - [ScreenSize.desktop]: width >= 600px
  static ScreenSize getScreenSize(double width) {
    if (width < Breakpoints.mobile) {
      return ScreenSize.mobile;
    } else {
      return ScreenSize.desktop;
    }
  }

  /// Returns true if the screen width is considered mobile (< 600px).
  static bool isMobile(double width) => width < Breakpoints.mobile;

  /// Returns true if the screen width is considered desktop (>= 600px).
  static bool isDesktop(double width) => width >= Breakpoints.mobile;

  /// Calculate responsive grid column count based on screen width.
  static int getGridColumnCount(double width) {
    if (width < Breakpoints.mobile) {
      return 2;
    } else {
      return 4;
    }
  }

  /// Calculate responsive grid column count for product grids.
  static int getProductGridColumnCount(double width) {
    if (width < Breakpoints.mobile) {
      return 2;
    } else {
      return 3;
    }
  }
}

/// Extension on BuildContext for convenient responsive helpers.
extension ResponsiveContext on BuildContext {
  /// Get the current screen width.
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Get the current screen size category.
  ScreenSize get screenSize => Responsive.getScreenSize(screenWidth);

  /// Returns true if the screen is mobile sized.
  bool get isMobile => Responsive.isMobile(screenWidth);

  /// Returns true if the screen is desktop sized.
  bool get isDesktop => Responsive.isDesktop(screenWidth);

  /// Get responsive grid column count for collection grids.
  int get gridColumnCount => Responsive.getGridColumnCount(screenWidth);

  /// Get responsive grid column count for product grids.
  int get productGridColumnCount =>
      Responsive.getProductGridColumnCount(screenWidth);
}
