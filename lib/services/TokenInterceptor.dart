import 'package:dio/dio.dart';
import 'TokenService.dart';

class AuthInterceptor extends Interceptor {
  TokenService tokenService = TokenService();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('*************INTERCEPTOR INSERT TOKEN*************');
    final token = await tokenService.getToken();
    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";
    } else {
      // TODO: Gérer le cas où il n'y a pas de token, par exemple rediriger vers un écran de login
    }
    super.onRequest(options, handler);
  }
}
