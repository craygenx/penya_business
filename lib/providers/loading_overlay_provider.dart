import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingOverlayNotifier extends StateNotifier<bool> {
  LoadingOverlayNotifier() : super(false);

  void show() => state = true;
  void hide() => state = false;
}

final loadingOverlayProvider = StateNotifierProvider<LoadingOverlayNotifier, bool>(
  (ref) => LoadingOverlayNotifier(),
);


class LoadingOverlay extends ConsumerStatefulWidget {
  final Widget child;
  const LoadingOverlay({super.key, required this.child});

  @override
  ConsumerState createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends ConsumerState<LoadingOverlay> {
  OverlayEntry? _overlayEntry;

  void _showOverlay(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Semi-transparent background
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          // Centered loading indicator
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Uploading Product...",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<bool>(loadingOverlayProvider, (previous, isLoading) {
      if (isLoading) {
        _showOverlay(context);
      } else {
        _removeOverlay();
      }
    });

    return widget.child;
  }
}
