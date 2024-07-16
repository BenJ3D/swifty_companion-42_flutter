import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app_links/app_links.dart';
import 'package:http/http.dart' as http;

class AuthToken {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final String refreshToken;
  final String scope;
  final int createdAt;
  final int secretValidUntil;

  AuthToken({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.refreshToken,
    required this.scope,
    required this.createdAt,
    required this.secretValidUntil,
  });

  factory AuthToken.fromJson(Map<String, dynamic> json) {
    return AuthToken(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      expiresIn: json['expires_in'],
      refreshToken: json['refresh_token'],
      scope: json['scope'],
      createdAt: json['created_at'],
      secretValidUntil: json['secret_valid_until'],
    );
  }
}

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

  Future<void> _handleCode(String code) async {
    try {
      final token = await _exchangeCodeForToken(code);
      // Utilisez le token comme vous le souhaitez
      print('Token obtenu: ${token.accessToken}');
    } catch (e) {
      print('Erreur lors de l\'obtention du token: $e');
    }
  }

  Future<AuthToken> _exchangeCodeForToken(String code) async {
    final url = Uri.parse('https://api.intra.42.fr/oauth/token');
    final response = await http.post(
      url,
      body: {
        'grant_type': 'authorization_code',
        'client_id': dotenv.env['CLIENT_UID'],
        'client_secret': dotenv.env['CLIENT_SECRET'],
        'code': code,
        'redirect_uri': dotenv.env['REDIRECT_URI'],
      },
    );

    if (response.statusCode == 200) {
      return AuthToken.fromJson(json.decode(response.body));
    } else {
      throw Exception('Échec de l\'obtention du token: ${response.body}');
    }
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
