import 'package:flutter/material.dart';
import 'package:union_shop/models/carousel_slide.dart';
import 'package:union_shop/styles/text_styles.dart';

class Carousel extends StatefulWidget {
  final List<CarouselSlide> slides;

  const Carousel({
    super.key,
    required this.slides,
  });

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  void _nextSlide() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % widget.slides.length;
    });
  }

  void _previousSlide() {
    setState(() {
      _currentIndex =
          (_currentIndex - 1 + widget.slides.length) % widget.slides.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.slides.isEmpty) {
      return const SizedBox.shrink();
    }

    final slide = widget.slides[_currentIndex];

    return SizedBox(
      height: 400,
      width: double.infinity,
      child: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Image.network(
                slide.imageUrl,
                key: ValueKey<String>(slide.imageUrl),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(color: Colors.grey[200]);
                },
              ),
            ),
          ),
          // Semi-transparent overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.7),
            ),
          ),
          // Content overlay
          Positioned(
            left: 24,
            right: 24,
            top: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  slide.title,
                  style: TextStyles.heroTitle,
                  key: ValueKey<String>('title-${_currentIndex}'),
                ),
                const SizedBox(height: 16),
                Text(
                  slide.subtitle,
                  style: TextStyles.heroSubtitle,
                  textAlign: TextAlign.center,
                  key: ValueKey<String>('subtitle-${_currentIndex}'),
                ),
              ],
            ),
          ),
          // Previous button
          Positioned(
            left: 16,
            top: 0,
            bottom: 0,
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                iconSize: 32,
                onPressed: _previousSlide,
                tooltip: 'Previous slide',
              ),
            ),
          ),
          // Next button
          Positioned(
            right: 16,
            top: 0,
            bottom: 0,
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.arrow_forward),
                color: Colors.white,
                iconSize: 32,
                onPressed: _nextSlide,
                tooltip: 'Next slide',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
