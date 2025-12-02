import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/models/carousel_slide.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/utils/responsive.dart';
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
        title: 'Summer Sale',
        subtitle:
            'Hot deals on cool styles! Up to 50% off selected items while stocks last.',
        ctaText: 'SHOP THE SALE',
        onCtaPressed: () {
          context.go('/collections/summer-sale');
        },
      ),
      CarouselSlide(
        imageUrl:
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
        title: 'Make It Yours',
        subtitle:
            'Add a personal touch with custom printing. Perfect for gifts, events, or treating yourself.',
        ctaText: 'PERSONALISE NOW',
        onCtaPressed: () {
          context.go('/print-shack');
        },
      ),
      CarouselSlide(
        imageUrl:
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
        title: 'Explore Our Collections',
        subtitle:
            'From everyday essentials to statement pieces — find something for every occasion.',
        ctaText: 'VIEW COLLECTIONS',
        onCtaPressed: () {
          context.go('/collections');
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
                  products: summerRangeProducts.take(2).toList(),
                ),
                const SizedBox(height: 64),
                // New Arrivals Section
                ProductSection(
                  title: 'New Arrivals',
                  products: newArrivalsProducts.take(2).toList(),
                ),
                const SizedBox(height: 64),
                // Featured Collection Section
                ProductSection(
                  title: 'Featured Collection',
                  products: featuredCollectionProducts,
                  showViewAll: true,
                  onViewAllPressed: () {
                    context.go('/collections');
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
                  crossAxisCount: context.isMobile ? 1 : 3,
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
