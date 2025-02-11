import 'package:app_links/app_links.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deepLinkProvider = Provider((ref)=>DeepLinkHandler());
class DeepLinkHandler {
  final _appLinks = AppLinks();
  Future<void> handleDeepLinks(Function(String)? onLinkReceived) async {
    final initialLink = await _appLinks.getInitialLink();
    if (initialLink != null) {
      onLinkReceived!(initialLink.toString());
    }
    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        onLinkReceived!(uri.toString());
      }
    }, onError: (Object error) {
      print('Error handling deep link: $error');
    }
    );
  }
}