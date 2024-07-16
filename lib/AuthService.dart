import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app_links/app_links.dart';

class AuthService {
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _sub;

  AuthService();

  Future<void> init() async {
    await initAppLinks();
  }

  Future<void> initAppLinks() async {
    _appLinks = AppLinks();

    _sub = _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleIncomingLink(uri);
      }
    }, onError: (err) {
      debugPrint('Erreur: $err');
    });

    try {
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        _handleIncomingLink(initialUri);
      }
    } catch (e) {
      debugPrint('Erreur lors de la récupération du lien initial: $e');
    }
  }

  void _handleIncomingLink(Uri uri) {
    final code = uri.queryParameters['code'];
    if (code != null) {
      _handleCode(code);
    }
  }

  void _handleCode(String code) {
    // Logique pour gérer le code d'autorisation
    print('Code d\'autorisation reçu: $code');
    // Ajoutez ici la logique pour traiter le code (par exemple, échanger le code contre un token)
  }

  Future<void> login() async {
    final Uri url = Uri.parse(dotenv.env['CLIENT_AUTHORIZE_URL'].toString());
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  void dispose() {
    _sub?.cancel();
  }
}
