import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/styles/text_styles.dart';

/// A search overlay that covers the navbar with a search input field.
///
/// Features:
/// - Text input with search icon
/// - Submit button to navigate to search results
/// - Close button to dismiss the overlay
/// - Keyboard Enter submits search
class SearchOverlay extends StatefulWidget {
  /// Callback when the overlay should be closed.
  final VoidCallback onClose;

  const SearchOverlay({
    super.key,
    required this.onClose,
  });

  @override
  State<SearchOverlay> createState() => _SearchOverlayState();
}

class _SearchOverlayState extends State<SearchOverlay> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Auto-focus the text field when overlay opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submitSearch() {
    final query = _controller.text.trim();
    if (query.isNotEmpty) {
      context.go('/search?q=${Uri.encodeQueryComponent(query)}');
    } else {
      context.go('/search');
    }
    widget.onClose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Search input
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: 'Search products...',
                hintStyle: TextStyles.searchHint,
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                filled: true,
                fillColor: Colors.white24,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              style: TextStyles.searchInput,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _submitSearch(),
            ),
          ),
          const SizedBox(width: 8),

          // Submit button
          IconButton(
            onPressed: _submitSearch,
            icon: const Icon(Icons.arrow_forward, color: Colors.white),
            tooltip: 'Search',
            style: IconButton.styleFrom(
              minimumSize: const Size(48, 48),
            ),
          ),

          // Close button
          IconButton(
            onPressed: widget.onClose,
            icon: const Icon(Icons.close, color: Colors.white),
            tooltip: 'Close search',
            style: IconButton.styleFrom(
              minimumSize: const Size(48, 48),
            ),
          ),
        ],
      ),
    );
  }
}
