import 'package:oauth2_client/oauth2_client.dart';

class MyOAuth2Client extends OAuth2Client {
  MyOAuth2Client({
    required super.redirectUri,
    required super.customUriScheme,
  }) : super(
            authorizeUrl:
                'https://api.intra.42.fr/oauth/authorize?client_id=u-s4t2ud-86d3c41ce824ecfbd42462d0281adaa8848d40dac02a762fbec5fde2651fb500&redirect_uri=myapp%3A%2F%2Fcallback&response_type=code',
            tokenUrl: 'https://api.intra.42.fr/oauth/token');
}
