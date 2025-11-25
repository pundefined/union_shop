/// Represents a single slide in the carousel
class CarouselSlide {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String? ctaText;
  final VoidCallback? onCtaPressed;

  const CarouselSlide({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    this.ctaText,
    this.onCtaPressed,
  });
}

typedef VoidCallback = void Function();
