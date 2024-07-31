import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:swifty_companion/components/homePage.dart';
import 'package:swifty_companion/services/ConnectivityService.dart';
import 'package:swifty_companion/services/TokenInterceptor.dart';
import 'services/NavigatorService.dart';
import 'services/AuthService.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

//TODO: gerer le token en ouverture d'app pour ne pas reloggin a chaque fois
//TODO: bull notif si erreur
//TODO: background image login avec logo ?
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  BaseOptions options = BaseOptions(
    baseUrl: 'https://api.intra.42.fr',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  );

  final dio = Dio(options);
  dio.interceptors.add(AuthInterceptor(dio));

  runApp(MyApp(dio: dio));
}

class MyApp extends StatelessWidget {
  final Dio dio;

  const MyApp({super.key, required this.dio});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigatorService().navigatorKey,
      routes: {
        '/login': (context) => const MyHomePage(
              title: 'Swifty Companion',
            ),
        '/profile': (context) => HomePage(
              dio: dio,
            )
      },
      title: 'Swifty Companion',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Swifty Companion'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AuthService _authService;
  final ConnectivityService _connectivityService = ConnectivityService();
  late Stream<ConnectivityResult> _connectivityStream;

  @override
  void initState() {
    super.initState();
    _authService = AuthService();
    _authService.init(context);
    _connectivityStream = _connectivityService.connectivityStream;
  }

  @override
  void dispose() {
    _authService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: _connectivityStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final connectivityResult = snapshot.data;
          if (connectivityResult == ConnectivityResult.none) {
            return const Scaffold(
              body: Center(
                child: Text('No internet connection'),
              ),
            );
          }
        }
        return Scaffold(
          backgroundColor: Colors.blueGrey.shade900,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Center(
              child: Text(
                widget.title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: () => _authService.login(context),
              style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColorLight,
                backgroundColor: Theme.of(context).primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
              ),
              child: const Text(
                'Login 42',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        );
      },
    );
  }
}
