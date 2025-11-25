import 'package:flutter/material.dart';
import 'package:union_shop/models/carousel_slide.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/widgets/carousel.dart';
import 'package:union_shop/widgets/product_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

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
                  products: [
                    Product(
                      id: 'home-product-1',
                      name: 'Placeholder Product 1',
                      price: 10.00,
                      imageUrl:
                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                      description: 'Placeholder Product 1',
                    ),
                    Product(
                      id: 'home-product-2',
                      name: 'Placeholder Product 2',
                      price: 15.00,
                      imageUrl:
                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                      description: 'Placeholder Product 2',
                    ),
                  ],
                ),
                const SizedBox(height: 64),
                // New Arrivals Section
                ProductSection(
                  title: 'New Arrivals',
                  products: [
                    Product(
                      id: 'home-product-3',
                      name: 'Placeholder Product 3',
                      price: 20.00,
                      imageUrl:
                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                      description: 'Placeholder Product 3',
                    ),
                    Product(
                      id: 'home-product-4',
                      name: 'Placeholder Product 4',
                      price: 25.00,
                      imageUrl:
                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                      description: 'Placeholder Product 4',
                    ),
                  ],
                ),
                const SizedBox(height: 64),
                // Featured Collection Section
                ProductSection(
                  title: 'Featured Collection',
                  products: [
                    Product(
                      id: 'collection-product-1',
                      name: 'Collection Product 1',
                      price: 12.00,
                      imageUrl:
                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                      description: 'Collection Product 1',
                    ),
                    Product(
                      id: 'collection-product-2',
                      name: 'Collection Product 2',
                      price: 18.00,
                      imageUrl:
                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                      description: 'Collection Product 2',
                    ),
                    Product(
                      id: 'collection-product-3',
                      name: 'Collection Product 3',
                      price: 22.00,
                      imageUrl:
                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                      description: 'Collection Product 3',
                    ),
                    Product(
                      id: 'collection-product-4',
                      name: 'Collection Product 4',
                      price: 28.00,
                      imageUrl:
                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                      description: 'Collection Product 4',
                    ),
                  ],
                  showViewAll: true,
                  onViewAllPressed: () {
                    Navigator.pushNamed(context, '/collections');
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
