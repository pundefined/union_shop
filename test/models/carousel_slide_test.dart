import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/carousel_slide.dart';

void main() {
  group('CarouselSlide Model Tests', () {
    test('creates CarouselSlide with required fields', () {
      const slide = CarouselSlide(
        imageUrl: 'assets/images/test.png',
        title: 'Test Title',
        subtitle: 'Test Subtitle',
      );

      expect(slide.imageUrl, 'assets/images/test.png');
      expect(slide.title, 'Test Title');
      expect(slide.subtitle, 'Test Subtitle');
    });

    test('ctaText is null by default', () {
      const slide = CarouselSlide(
        imageUrl: 'assets/images/test.png',
        title: 'Test Title',
        subtitle: 'Test Subtitle',
      );

      expect(slide.ctaText, isNull);
    });

    test('onCtaPressed is null by default', () {
      const slide = CarouselSlide(
        imageUrl: 'assets/images/test.png',
        title: 'Test Title',
        subtitle: 'Test Subtitle',
      );

      expect(slide.onCtaPressed, isNull);
    });

    test('creates CarouselSlide with optional ctaText', () {
      const slide = CarouselSlide(
        imageUrl: 'assets/images/test.png',
        title: 'Test Title',
        subtitle: 'Test Subtitle',
        ctaText: 'Shop Now',
      );

      expect(slide.ctaText, 'Shop Now');
    });

    test('creates CarouselSlide with optional onCtaPressed callback', () {
      bool callbackCalled = false;

      final slide = CarouselSlide(
        imageUrl: 'assets/images/test.png',
        title: 'Test Title',
        subtitle: 'Test Subtitle',
        ctaText: 'Shop Now',
        onCtaPressed: () => callbackCalled = true,
      );

      expect(slide.onCtaPressed, isNotNull);

      slide.onCtaPressed!();
      expect(callbackCalled, isTrue);
    });

    test('creates CarouselSlide with all fields', () {
      bool callbackCalled = false;

      final slide = CarouselSlide(
        imageUrl: 'assets/images/banner.png',
        title: 'Big Sale',
        subtitle: 'Up to 50% off',
        ctaText: 'Shop Now',
        onCtaPressed: () => callbackCalled = true,
      );

      expect(slide.imageUrl, 'assets/images/banner.png');
      expect(slide.title, 'Big Sale');
      expect(slide.subtitle, 'Up to 50% off');
      expect(slide.ctaText, 'Shop Now');
      expect(slide.onCtaPressed, isNotNull);

      slide.onCtaPressed!();
      expect(callbackCalled, isTrue);
    });

    test('can create const CarouselSlide without callbacks', () {
      const slide = CarouselSlide(
        imageUrl: 'assets/images/test.png',
        title: 'Const Slide',
        subtitle: 'This is const',
      );

      expect(slide.title, 'Const Slide');
    });

    test('different slides are independent', () {
      const slide1 = CarouselSlide(
        imageUrl: 'assets/images/slide1.png',
        title: 'Slide 1',
        subtitle: 'Subtitle 1',
      );

      const slide2 = CarouselSlide(
        imageUrl: 'assets/images/slide2.png',
        title: 'Slide 2',
        subtitle: 'Subtitle 2',
      );

      expect(slide1.title, isNot(equals(slide2.title)));
      expect(slide1.imageUrl, isNot(equals(slide2.imageUrl)));
    });
  });
}
