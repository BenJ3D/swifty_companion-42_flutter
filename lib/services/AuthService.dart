import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:swifty_companion/main.dart';
import 'package:swifty_companion/services/NavigatorService.dart';
import 'package:swifty_companion/services/TokenService.dart';
import 'package:swifty_companion/tools/AnsiColor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app_links/app_links.dart';
import 'package:http/http.dart' as http;

import '../components/homePage.dart';

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
  late TokenService tokenService = TokenService();

  AuthService();

  Future<void> init(BuildContext context) async {
    print("${AnsiColor.magenta.code}BONJOUR ICI LA INIT APP LINKS");

    await initAppLinks(context);
  }

  Future<void> initAppLinks(BuildContext context) async {
    _appLinks = AppLinks();

    _sub = _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleIncomingLink(uri, context);
      }
    }, onError: (err) {
      debugPrint('Erreur: $err');
    });

    try {
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null && context.mounted) {
        _handleIncomingLink(initialUri, context);
      }
    } catch (e) {
      debugPrint('Erreur lors de la récupération du lien initial: $e');
    }
  }

  void _handleIncomingLink(Uri uri, BuildContext context) {
    final code = uri.queryParameters['code'];
    if (code != null) {
      _handleCode(code, context);
    }
  }

  Future<void> _handleCode(String code, BuildContext context) async {
    try {
      final token = await _exchangeCodeForToken(code);
      // Utilisez le token comme vous le souhaitez
      print(
          '${AnsiColor.magenta.code}Token obtenu: ${AnsiColor.green.code}${token.accessToken}${AnsiColor.reset.code}');
      await tokenService.saveToken(token.accessToken);
      await tokenService.saveRefreshToken(token.refreshToken);
      await tokenService.saveExpiresToken(token.createdAt + token.expiresIn);
      if (context.mounted) {
        _loginSuccess(context);
      }
    } catch (e) {
      print('Erreur lors de l\'obtention du token: $e');
    }
  }

  Future<bool> handleRefreshToken() async {
    try {
      final token = await _refreshToken();
      // Utilisez le token comme vous le souhaitez
      print(
          '${AnsiColor.magenta.code}Nouveau token obtenu:${AnsiColor.green.code} ${token.accessToken}${AnsiColor.reset.code}');
      await tokenService.saveToken(token.accessToken);
      await tokenService.saveRefreshToken(token.refreshToken);
      await tokenService.saveExpiresToken(token.createdAt + token.expiresIn);
      return true;
    } catch (e) {
      print('Erreur lors de l\'obtention du token via refreshToken: $e');
      return false;
    }
  }

  void _loginSuccess(BuildContext context) {
    // NavigatorService().navigateTo('/profile');
    Navigator.pushReplacementNamed(context, "/profile");
  }

  void loginFail(BuildContext context) {
    // Navigator.pushReplacementNamed(context, "/login");
    NavigatorService().navigateToAndRemoveAll('/login');
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

  Future<AuthToken> _refreshToken() async {
    final url = Uri.parse('https://api.intra.42.fr/oauth/token');
    final tokenRefresh = await tokenService.getRefreshToken();
    final response = await http.post(
      url,
      body: {
        'grant_type': 'refresh_token',
        'client_id': dotenv.env['CLIENT_UID'],
        'client_secret': dotenv.env['CLIENT_SECRET'],
        'refresh_token': tokenRefresh ?? '',
        'redirect_uri': dotenv.env['REDIRECT_URI'],
      },
    );

    if (response.statusCode == 200) {
      print('response ======= : ${response.body}');
      return AuthToken.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Échec de l\'obtention du token avec refresh: ${response.body}');
    }
  }

  Future<void> login(BuildContext context) async {
    final Uri url = Uri.parse(dotenv.env['CLIENT_AUTHORIZE_URL'].toString());
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  void dispose() {
    _sub?.cancel();
  }
}
