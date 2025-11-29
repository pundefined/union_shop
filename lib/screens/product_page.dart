import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../models/product.dart';
import '../styles/text_styles.dart';
import '../widgets/color_selector.dart';
import '../widgets/size_selector.dart';
import '../widgets/quantity_selector.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String? selectedColour;
  String? selectedSize;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    // Set default color to first available
    if (widget.product.colors != null && widget.product.colors!.isNotEmpty) {
      selectedColour = widget.product.colors!.first;
    }
    // Set default size to 'M' if available, otherwise first available
    if (widget.product.sizes != null && widget.product.sizes!.isNotEmpty) {
      selectedSize = widget.product.sizes!.contains('M')
          ? 'M'
          : widget.product.sizes!.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Product details
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    widget.product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_not_supported,
                                size: 64,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Image unavailable',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Product name
              Text(
                widget.product.name,
                style: TextStyles.productHeading,
              ),

              const SizedBox(height: 12),

              // Product price section
              Row(
                children: [
                  Text(
                    '£${widget.product.price.toStringAsFixed(2)}',
                    style: TextStyles.getPriceStyle(
                      isDiscounted: widget.product.discountedPrice != null,
                    ),
                  ),
                  if (widget.product.discountedPrice != null) ...[
                    const SizedBox(width: 12),
                    Text(
                      '£${widget.product.discountedPrice!.toStringAsFixed(2)}',
                      style: TextStyles.productPrice,
                    ),
                  ],
                ],
              ),

              const SizedBox(height: 24),

              // Product description
              const Text(
                'Description',
                style: TextStyles.subHeading,
              ),
              const SizedBox(height: 8),
              Text(
                widget.product.description,
                style: TextStyles.bodyText,
              ),

              // Color selector (shown only if colours are available)
              if (widget.product.colors != null &&
                  widget.product.colors!.isNotEmpty) ...[
                const SizedBox(height: 24),
                ColorSelector(
                  colors: widget.product.colors!,
                  selectedColour: selectedColour,
                  onChanged: (value) {
                    setState(() {
                      selectedColour = value;
                    });
                  },
                ),
              ],

              // Size selector (shown only if sizes are available)
              if (widget.product.sizes != null &&
                  widget.product.sizes!.isNotEmpty) ...[
                const SizedBox(height: 24),
                SizeSelector(
                  sizes: widget.product.sizes!,
                  selectedSize: selectedSize,
                  onChanged: (value) {
                    setState(() {
                      selectedSize = value;
                    });
                  },
                ),
              ],

              // Quantity selector
              const SizedBox(height: 24),
              QuantitySelector(
                quantity: quantity,
                onChanged: (value) {
                  setState(() {
                    quantity = value;
                  });
                },
              ),

              // Add to Cart button
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<CartProvider>().addItem(
                          product: widget.product,
                          quantity: quantity,
                          selectedColor: selectedColour,
                          selectedSize: selectedSize,
                        );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Added ${widget.product.name} x$quantity to cart',
                        ),
                      ),
                    );
                  },
                  child: const Text('Add to Cart'),
                ),
              ),

              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Back to store'),
                ),
              ),
            ],
          ),
        ),

        // Footer is now provided by the shared AppShell footer widget.
      ],
    );
  }
}
