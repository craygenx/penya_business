import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToastState {
  final String message;
  final IconData icon;
  final Color backgroundColor;

  ToastState({
    required this.message,
    required this.icon,
    required this.backgroundColor,
  });
}

/// StateNotifier for managing toast state
class ToastNotifier extends StateNotifier<ToastState?> {
  ToastNotifier() : super(null);

  /// Show toast function
  void showToast({
    required String message,
    required IconData icon,
    Color backgroundColor = Colors.black,
  }) {
    state = ToastState(
      message: message,
      icon: icon,
      backgroundColor: backgroundColor,
    );

    // Clear toast after 3 seconds
    Future.delayed(const Duration(seconds: 3), () => state = null);
  }
}

/// Riverpod provider for toast
final toastProvider = StateNotifierProvider<ToastNotifier, ToastState?>((ref) {
  return ToastNotifier();
});


class ToastListener extends ConsumerStatefulWidget {
  final Widget child;

  const ToastListener({super.key, required this.child});

  @override
  ConsumerState<ToastListener > createState() => _ToastListenerState();
}

class _ToastListenerState extends ConsumerState<ToastListener> {
  OverlayEntry? _overlayEntry;

  void _showOverlay(BuildContext context, ToastState toast) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50, // Adjust as needed
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: toast.backgroundColor.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(toast.icon, color: Colors.white),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    toast.message,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);

    Future.delayed(const Duration(seconds: 3), () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ToastState?>(toastProvider, (previous, next) {
      if (next != null) {
        _showOverlay(context, next);
      }
    });

    return widget.child;
  }
}
