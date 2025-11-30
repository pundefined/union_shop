import 'package:flutter/material.dart';
import 'package:union_shop/models/carousel_slide.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/widgets/carousel.dart';
import 'package:union_shop/widgets/collection_tile.dart';
import 'package:union_shop/widgets/product_section.dart';

/// The home page content widget.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final carouselSlides = [
      CarouselSlide(
        imageUrl:
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
        title: 'Placeholder Hero Title',
        subtitle: 'This is placeholder text for the hero section.',
        ctaText: 'BROWSE PRODUCTS',
        onCtaPressed: () {
          // TODO: Implement navigation to products page
        },
      ),
      CarouselSlide(
        imageUrl:
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
        title: 'Second Slide Title',
        subtitle: 'This is placeholder text for the second slide.',
        ctaText: 'BROWSE PRODUCTS',
        onCtaPressed: () {
          // TODO: Implement navigation to products page
        },
      ),
      CarouselSlide(
        imageUrl:
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
        title: 'Third Slide Title',
        subtitle: 'This is placeholder text for the third slide.',
        ctaText: 'BROWSE PRODUCTS',
        onCtaPressed: () {
          // TODO: Implement navigation to products page
        },
      ),
    ];

    return Column(
      children: [
        // Hero Section with Carousel
        Carousel(slides: carouselSlides),

        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                // Summer Range Section
                ProductSection(
                  title: 'Summer Range',
                  products: summerRangeProducts,
                ),
                const SizedBox(height: 64),
                // New Arrivals Section
                ProductSection(
                  title: 'New Arrivals',
                  products: newArrivalsProducts,
                ),
                const SizedBox(height: 64),
                // Featured Collection Section
                ProductSection(
                  title: 'Featured Collection',
                  products: featuredCollectionProducts,
                  showViewAll: true,
                  onViewAllPressed: () {
                    Navigator.pushNamed(context, '/collections');
                  },
                ),
                const SizedBox(height: 64),
                // Categories Header
                Text(
                  'OUR RANGE',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                ),
                const SizedBox(height: 32),
                // Category Links Grid
                GridView.count(
                  crossAxisCount:
                      MediaQuery.of(context).size.width > 600 ? 3 : 1,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: sampleCollections
                      .map((collection) =>
                          CollectionTile(collection: collection))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
