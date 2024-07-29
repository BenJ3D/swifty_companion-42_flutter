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

// Fonction pour récupérer le token
  Future<String?> getRefreshToken() async {
    return await storage.read(key: 'auth_refresh_token');
  }

// Fonction pour supprimer le token
  Future<void> deleteToken() async {
    await storage.write(key: 'auth_token', value: 'null');

    // await storage.delete(key: 'auth_token');
  }

// Fonction pour supprimer le token
  Future<void> deleteRefreshToken() async {
    await storage.delete(key: 'auth_refresh_token');
  }

//***********************************************************************
//***********************************************************************
  void _printTokenExpire(int timestamp) {
    // Convertir le timestamp en objet DateTime
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    // Afficher la date et l'heure
    print(_formatDate(date)); // Format personnalisé
  }

// Fonction pour formater la date et l'heure
  String _formatDate(DateTime date) {
    return "${AnsiColor.blue.code}Le token expire le: ${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} "
        "${AnsiColor.red.code}${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')} ${AnsiColor.reset.code}";
  }
//***********************************************************************
//***********************************************************************
}
