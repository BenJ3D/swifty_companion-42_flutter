import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:swifty_companion/services/AuthService.dart';
import 'package:swifty_companion/services/NavigatorService.dart';
import 'package:swifty_companion/tools/AnsiColor.dart';
import 'TokenService.dart';
import 'ConnectivityService.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final TokenService tokenService = TokenService();
  final AuthService authService = AuthService();
  final ConnectivityService connectivityService = ConnectivityService();

  AuthInterceptor(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('*************INTERCEPTOR INSERT TOKEN*************');
    // Vérifier la connectivité réseau
    final connectivityResult = await connectivityService.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: 'No internet connection',
          type: DioExceptionType.unknown,
        ),
      );
    }

    final token = await tokenService.getToken();
    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";
    } else {
      NavigatorService().navigateToAndRemoveAll('/login');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Traitez les réponses normalement
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print('************* INTERCEPTOR ERROR *************');
    // Vérifiez si le code d'erreur est 401
    if (err.response?.statusCode == 401) {
      print(
          '${AnsiColor.red.code}************* 401 !!! *************${AnsiColor.reset.code}');
      print(
          '${AnsiColor.blue.code}************* TRY REFRESH TOKEN *************${AnsiColor.reset.code}');

      // Tentez de rafraîchir le token
      bool refreshed = await authService.handleRefreshToken();
      if (refreshed) {
        // Clonez la requête d'origine
        final opts = Options(
          method: err.requestOptions.method,
          headers: err.requestOptions.headers,
        );
        // Relancez la requête avec le nouveau token
        try {
          final token = await tokenService.getToken();
          if (token != null) {
            err.requestOptions.headers["Authorization"] = "Bearer $token";
          }
          final cloneReq = await dio.request(
            err.requestOptions.path,
            options: opts,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
          );
          return handler.resolve(cloneReq);
        } catch (e) {
          return handler.next(err);
        }
      } else {
        print(
            '${AnsiColor.red.code}Refresh token fail, please re login${AnsiColor.reset.code}');
        NavigatorService().navigateToAndRemoveAll('/login');
      }
    }
    // Si l'erreur n'est pas un 401, la traiter normalement
    return handler.next(err);
  }
}
