import 'package:flutter/material.dart';

/// A reusable top navigation bar used across the app.
class AppNavbar extends StatelessWidget {
  final VoidCallback? onLogoTap;
  final VoidCallback? onSearch;
  final VoidCallback? onAccount;
  final VoidCallback? onCart;
  final VoidCallback? onMenu;

  const AppNavbar({
    Key? key,
    this.onLogoTap,
    this.onSearch,
    this.onAccount,
    this.onCart,
    this.onMenu,
  }) : super(key: key);

  void _navigateHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.white,
      child: Column(
        children: [
          // Top banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: const Color(0xFF4d2963),
            child: const Text(
              'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),

          // Main header row
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  // Logo with semantic label and minimum tappable area
                  Semantics(
                    label: 'Home',
                    button: true,
                    child: InkWell(
                      onTap: onLogoTap ?? () => _navigateHome(context),
                      child: const SizedBox(
                        height: 48,
                        child: Center(
                          child: ImageNetworkLogo(),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Center(
                      child: Semantics(
                        label: 'About',
                        button: true,
                        child: TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/about'),
                          style: TextButton.styleFrom(
                            minimumSize: const Size(48, 48),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            foregroundColor: Colors.black,
                          ),
                          child: const Text('About'),
                        ),
                      ),
                    ),
                  ),

                  // Right-side icons constrained in width
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.search,
                            size: 18,
                            color: Colors.grey,
                          ),
                          padding: const EdgeInsets.all(8),
                          constraints: const BoxConstraints(
                            minWidth: 48,
                            minHeight: 48,
                          ),
                          onPressed: onSearch ?? () {},
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.person_outline,
                            size: 18,
                            color: Colors.grey,
                          ),
                          padding: const EdgeInsets.all(8),
                          constraints: const BoxConstraints(
                            minWidth: 48,
                            minHeight: 48,
                          ),
                          onPressed: onAccount ?? () {},
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.shopping_bag_outlined,
                            size: 18,
                            color: Colors.grey,
                          ),
                          padding: const EdgeInsets.all(8),
                          constraints: const BoxConstraints(
                            minWidth: 48,
                            minHeight: 48,
                          ),
                          onPressed: onCart ?? () {},
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.menu,
                            size: 18,
                            color: Colors.grey,
                          ),
                          padding: const EdgeInsets.all(8),
                          constraints: const BoxConstraints(
                            minWidth: 48,
                            minHeight: 48,
                          ),
                          onPressed: onMenu ?? () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Small stateless widget to keep the image construction const-friendly
/// while preserving the same NetworkImage + errorBuilder behavior.
class ImageNetworkLogo extends StatelessWidget {
  const ImageNetworkLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
      height: 18,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey[300],
          width: 18,
          height: 18,
          child: const Center(
            child: Icon(Icons.image_not_supported, color: Colors.grey),
          ),
        );
      },
    );
  }
}
