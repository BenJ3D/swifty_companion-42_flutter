import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:swifty_companion/tools/AnsiColor.dart';

class TokenService {
  // Créer une instance de FlutterSecureStorage
  static const storage = FlutterSecureStorage();

// Fonction pour sauvegarder le token
  Future<void> saveToken(String token) async {
    await storage.write(key: 'auth_token', value: token);
  }

// Fonction pour sauvegarder le token
  Future<void> saveExpiresToken(int expireDate) async {
    await storage.write(
        key: 'auth_expires_token', value: expireDate.toString());
    _printTokenExpire(expireDate);
  }

// Fonction pour sauvegarder le token
  Future<void> saveRefreshToken(String refreshToken) async {
    await storage.write(key: 'auth_refresh_token', value: refreshToken);
  }

// Fonction pour récupérer le token
  Future<String?> getToken() async {
    return await storage.read(key: 'auth_token');
  }

// Fonction pour récupérer le token refresh
  Future<String?> getRefreshToken() async {
    return await storage.read(key: 'auth_refresh_token');
  }

// Fonction pour récupérer le token expire date
  Future<String?> getExpiresToken() async {
    return await storage.read(key: 'auth_expires_token');
  }

// Fonction pour supprimer le token
  Future<void> deleteToken() async {
    await storage.write(key: 'auth_token', value: 'null');
  }

// Fonction pour supprimer le token
  Future<void> deleteRefreshToken() async {
    await storage.write(key: 'auth_refresh_token', value: 'null');
  }

  Future<void> printTokenInfo() async {
    String? expireDate = await getExpiresToken();
    String? token = await getToken();
    String? refreshToken = await getRefreshToken();
    if (expireDate != null && token != null && refreshToken != null) {
      print(
          '${AnsiColor.magenta.code}Token: ${AnsiColor.green.code}$token${AnsiColor.reset.code}\n${AnsiColor.magenta.code}RefreshToken: ${AnsiColor.blue.code}$refreshToken${AnsiColor.reset.code}');
      _printTokenExpire(int.parse(expireDate));
    }
  }

//***********************************************************************
//***********************************************************************
  void _printTokenExpire(int timestamp) {
    // Convertir le timestamp en objet DateTime
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    // Afficher la date et l'heure
    print(
        '${AnsiColor.magenta.code}Timestamp : ${AnsiColor.red.code}${timestamp}${AnsiColor.reset.code}');
    print(_formatDate(date)); // Format personnalisé
  }

// Fonction pour formater la date et l'heure
  String _formatDate(DateTime date) {
    return "${AnsiColor.magenta.code}Expire à: "
        "${AnsiColor.red.code}${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')} ${AnsiColor.reset.code}"
        "${AnsiColor.blue.code} (${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')})${AnsiColor.reset.code}";
  }
//***********************************************************************
//***********************************************************************
}
