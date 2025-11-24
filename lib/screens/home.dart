import 'package:flutter/material.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/styles/text_styles.dart';
import 'package:union_shop/widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Hero Section
        SizedBox(
          height: 400,
          width: double.infinity,
          child: Stack(
            children: [
              // Background image rendered via Image.network so we can provide
              // an errorBuilder and avoid test-time network exceptions.
              Positioned.fill(
                child: Image.network(
                  'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(color: Colors.grey[200]);
                  },
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
                    const Text(
                      'Placeholder Hero Title',
                      style: TextStyles.heroTitle,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "This is placeholder text for the hero section.",
                      style: TextStyles.heroSubtitle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: placeholderCallbackForButtons,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4d2963),
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: const Text(
                        'BROWSE PRODUCTS',
                        style: TextStyles.buttonText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

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
