import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/carousel_slide.dart';
import 'package:union_shop/widgets/carousel.dart';

import '../helpers/widget_test_helper.dart';

void main() {
  group('Carousel Widget Tests', () {
    final testSlides = [
      const CarouselSlide(
        imageUrl: 'assets/images/backpack.png',
        title: 'Slide 1',
        subtitle: 'Subtitle 1',
      ),
      const CarouselSlide(
        imageUrl: 'assets/images/backpack.png',
        title: 'Slide 2',
        subtitle: 'Subtitle 2',
      ),
      const CarouselSlide(
        imageUrl: 'assets/images/backpack.png',
        title: 'Slide 3',
        subtitle: 'Subtitle 3',
      ),
    ];

    testWidgets('renders empty when no slides provided', (tester) async {
      await tester.pumpWidget(
        wrapWidget(const Carousel(slides: [])),
      );

      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('displays first slide initially', (tester) async {
      await tester.pumpWidget(
        wrapWidgetScrollable(Carousel(slides: testSlides)),
      );

      expect(find.text('Slide 1'), findsOneWidget);
      expect(find.text('Subtitle 1'), findsOneWidget);
    });

    testWidgets('renders navigation buttons', (tester) async {
      await tester.pumpWidget(
        wrapWidgetScrollable(Carousel(slides: testSlides)),
      );

      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('renders indicator dots for each slide', (tester) async {
      await tester.pumpWidget(
        wrapWidgetScrollable(Carousel(slides: testSlides)),
      );

      // Find indicator dot containers
      final dots = find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).shape == BoxShape.circle,
      );

      expect(dots, findsNWidgets(testSlides.length));
    });

    testWidgets('next button advances to next slide', (tester) async {
      await tester.pumpWidget(
        wrapWidgetScrollable(Carousel(slides: testSlides)),
      );

      // Initially shows slide 1
      expect(find.text('Slide 1'), findsOneWidget);

      // Tap next button
      await tester.tap(find.byIcon(Icons.arrow_forward));
      await tester.pumpAndSettle();

      // Should now show slide 2
      expect(find.text('Slide 2'), findsOneWidget);
    });

    testWidgets('previous button goes to previous slide', (tester) async {
      await tester.pumpWidget(
        wrapWidgetScrollable(Carousel(slides: testSlides)),
      );

      // Tap next to go to slide 2
      await tester.tap(find.byIcon(Icons.arrow_forward));
      await tester.pumpAndSettle();
      expect(find.text('Slide 2'), findsOneWidget);

      // Tap previous to go back to slide 1
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      expect(find.text('Slide 1'), findsOneWidget);
    });

    testWidgets('carousel loops at boundaries', (tester) async {
      await tester.pumpWidget(
        wrapWidgetScrollable(Carousel(slides: testSlides)),
      );

      // Go to last slide by pressing next twice
      await tester.tap(find.byIcon(Icons.arrow_forward));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.arrow_forward));
      await tester.pumpAndSettle();
      expect(find.text('Slide 3'), findsOneWidget);

      // Press next again - should loop to first slide
      await tester.tap(find.byIcon(Icons.arrow_forward));
      await tester.pumpAndSettle();
      expect(find.text('Slide 1'), findsOneWidget);
    });

    testWidgets('carousel loops backwards from first slide', (tester) async {
      await tester.pumpWidget(
        wrapWidgetScrollable(Carousel(slides: testSlides)),
      );

      // Initially at slide 1
      expect(find.text('Slide 1'), findsOneWidget);

      // Press previous - should loop to last slide
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      expect(find.text('Slide 3'), findsOneWidget);
    });

    testWidgets('tapping indicator dot navigates to that slide',
        (tester) async {
      await tester.pumpWidget(
        wrapWidgetScrollable(Carousel(slides: testSlides)),
      );

      // Find indicator dot containers (circular containers inside GestureDetector)
      final dotContainers = find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).shape == BoxShape.circle,
      );

      // There should be 3 dots for 3 slides
      expect(dotContainers, findsNWidgets(3));

      // Tap the third dot by finding the GestureDetector ancestor of the third container
      final thirdDot = find.ancestor(
        of: dotContainers.at(2),
        matching: find.byType(GestureDetector),
      );
      await tester.tap(thirdDot.first);
      await tester.pumpAndSettle();

      expect(find.text('Slide 3'), findsOneWidget);
    });

    testWidgets('displays CTA button when provided', (tester) async {
      bool ctaPressed = false;
      final slideWithCta = [
        CarouselSlide(
          imageUrl: 'assets/images/backpack.png',
          title: 'CTA Slide',
          subtitle: 'Subtitle',
          ctaText: 'Shop Now',
          onCtaPressed: () => ctaPressed = true,
        ),
      ];

      await tester.pumpWidget(
        wrapWidgetScrollable(Carousel(slides: slideWithCta)),
      );

      expect(find.text('Shop Now'), findsOneWidget);

      // Tap the CTA button
      await tester.tap(find.text('Shop Now'));
      await tester.pump();

      expect(ctaPressed, isTrue);
    });

    testWidgets('hides CTA button when not provided', (tester) async {
      final slideWithoutCta = [
        const CarouselSlide(
          imageUrl: 'assets/images/backpack.png',
          title: 'No CTA Slide',
          subtitle: 'Subtitle',
        ),
      ];

      await tester.pumpWidget(
        wrapWidgetScrollable(Carousel(slides: slideWithoutCta)),
      );

      expect(find.byType(ElevatedButton), findsNothing);
    });
  });
}
