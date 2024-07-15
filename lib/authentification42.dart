// ignore_for_file: avoid_print

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:oauth2_client/google_oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:swifty_companion/MyOAuth2Client.dart';

class Oauth2Client42 {
  Oauth2Client42();

  Future<void> fetchFiles() async {
    var hlp = OAuth2Helper(
      MyOAuth2Client(
          redirectUri: dotenv.env["URI42"].toString(),
          customUriScheme: 'myapp'),
      grantType: OAuth2Helper.authorizationCode,
      clientId: dotenv.env["CLIENT_UID"].toString(),
      clientSecret: dotenv.env["CLIENT_SECRET"].toString(),
    );

    var resp = await hlp.get('https://api.intra.42.fr/v2/me');

    print(resp.body);
  }
}
