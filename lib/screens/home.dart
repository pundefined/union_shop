import 'package:flutter/material.dart';
import 'package:union_shop/models/carousel_slide.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/styles/text_styles.dart';
import 'package:union_shop/widgets/carousel.dart';
import 'package:union_shop/widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  @override
  Widget build(BuildContext context) {
    final carouselSlides = [
      const CarouselSlide(
        imageUrl:
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
        title: 'Placeholder Hero Title',
        subtitle: 'This is placeholder text for the hero section.',
      ),
      const CarouselSlide(
        imageUrl:
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
        title: 'Second Slide Title',
        subtitle: 'This is placeholder text for the second slide.',
      ),
      const CarouselSlide(
        imageUrl:
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
        title: 'Third Slide Title',
        subtitle: 'This is placeholder text for the third slide.',
      ),
    ];

    return Column(
      children: [
        // Hero Section with Carousel
        Carousel(slides: carouselSlides),

        // Products Section
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                const Text(
                  'PRODUCTS SECTION',
                  style: TextStyles.sectionHeading,
                ),
                const SizedBox(height: 48),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount:
                      MediaQuery.of(context).size.width > 600 ? 2 : 1,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 48,
                  children: [
                    ProductCard(
                      product: Product(
                        id: 'home-product-1',
                        name: 'Placeholder Product 1',
                        price: 10.00,
                        imageUrl:
                            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                        description: 'Placeholder Product 1',
                      ),
                    ),
                    ProductCard(
                      product: Product(
                        id: 'home-product-2',
                        name: 'Placeholder Product 2',
                        price: 15.00,
                        imageUrl:
                            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                        description: 'Placeholder Product 2',
                      ),
                    ),
                    ProductCard(
                      product: Product(
                        id: 'home-product-3',
                        name: 'Placeholder Product 3',
                        price: 20.00,
                        imageUrl:
                            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                        description: 'Placeholder Product 3',
                      ),
                    ),
                    ProductCard(
                      product: Product(
                        id: 'home-product-4',
                        name: 'Placeholder Product 4',
                        price: 25.00,
                        imageUrl:
                            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                        description: 'Placeholder Product 4',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
