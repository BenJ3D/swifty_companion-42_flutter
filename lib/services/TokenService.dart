import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  // Créer une instance de FlutterSecureStorage
  static const storage = FlutterSecureStorage();

// Fonction pour sauvegarder le token
  Future<void> saveToken(String token) async {
    await storage.write(key: 'auth_token', value: token);
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

  Future<void> refreshToken() async {}
}
