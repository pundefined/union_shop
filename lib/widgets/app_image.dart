import 'package:flutter/material.dart';

/// A helper widget that automatically displays images from either
/// local assets or network URLs based on the path format.
///
/// - Paths starting with 'assets/' are treated as local assets
/// - Paths starting with 'http://' or 'https://' are treated as network images
class AppImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  const AppImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.errorBuilder,
  });

  bool get isAsset => imageUrl.startsWith('assets/');

  @override
  Widget build(BuildContext context) {
    Container defaultErrorBuilder(
        BuildContext ctx, Object error, StackTrace? stack) {
      return Container(
        color: Colors.grey[300],
        child: const Center(
          child: Icon(
            Icons.image_not_supported,
            color: Colors.grey,
            size: 40,
          ),
        ),
      );
    }

    if (isAsset) {
      return Image.asset(
        imageUrl,
        fit: fit,
        errorBuilder: errorBuilder ?? defaultErrorBuilder,
      );
    } else {
      return Image.network(
        imageUrl,
        fit: fit,
        errorBuilder: errorBuilder ?? defaultErrorBuilder,
      );
    }
  }
}
