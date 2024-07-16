import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class MyOAuth2Client {
  MyOAuth2Client() {
    print("CLIENT_UID: ${dotenv.env['CLIENT_UID']}");
    print("CLIENT_SECRET: ${dotenv.env['CLIENT_SECRET']}");
    print("CLIENT_AUTHORIZE_URL: ${dotenv.env['CLIENT_AUTHORIZE_URL']}");
    print("URI42: ${dotenv.env['URI42']}");
  }

  getAuthCode() {}
}
