import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/utils/responsive.dart';

void main() {
  group('Responsive utilities', () {
    group('Breakpoints', () {
      test('mobile breakpoint is 600', () {
        expect(Breakpoints.mobile, 600.0);
      });
    });

    group('Responsive.getScreenSize', () {
      test('returns mobile for width < 600', () {
        expect(Responsive.getScreenSize(0), ScreenSize.mobile);
        expect(Responsive.getScreenSize(300), ScreenSize.mobile);
        expect(Responsive.getScreenSize(599), ScreenSize.mobile);
      });

      test('returns desktop for width >= 600', () {
        expect(Responsive.getScreenSize(600), ScreenSize.desktop);
        expect(Responsive.getScreenSize(900), ScreenSize.desktop);
        expect(Responsive.getScreenSize(1920), ScreenSize.desktop);
      });
    });

    group('Responsive.isMobile', () {
      test('returns true for width < 600', () {
        expect(Responsive.isMobile(0), true);
        expect(Responsive.isMobile(599), true);
      });

      test('returns false for width >= 600', () {
        expect(Responsive.isMobile(600), false);
        expect(Responsive.isMobile(900), false);
      });
    });

    group('Responsive.isDesktop', () {
      test('returns true for width >= 600', () {
        expect(Responsive.isDesktop(600), true);
        expect(Responsive.isDesktop(1200), true);
      });

      test('returns false for width < 600', () {
        expect(Responsive.isDesktop(599), false);
        expect(Responsive.isDesktop(0), false);
      });
    });

    group('Responsive.getGridColumnCount', () {
      test('returns 2 for mobile (< 600)', () {
        expect(Responsive.getGridColumnCount(0), 2);
        expect(Responsive.getGridColumnCount(400), 2);
        expect(Responsive.getGridColumnCount(599), 2);
      });

      test('returns 4 for desktop (>= 600)', () {
        expect(Responsive.getGridColumnCount(600), 4);
        expect(Responsive.getGridColumnCount(900), 4);
        expect(Responsive.getGridColumnCount(1920), 4);
      });
    });

    group('Responsive.getProductGridColumnCount', () {
      test('returns 2 for mobile (< 600)', () {
        expect(Responsive.getProductGridColumnCount(0), 2);
        expect(Responsive.getProductGridColumnCount(400), 2);
        expect(Responsive.getProductGridColumnCount(599), 2);
      });

      test('returns 3 for desktop (>= 600)', () {
        expect(Responsive.getProductGridColumnCount(600), 3);
        expect(Responsive.getProductGridColumnCount(900), 3);
        expect(Responsive.getProductGridColumnCount(1200), 3);
      });
    });
  });
}
