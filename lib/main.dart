import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:swifty_companion/MyOAuth2Client.dart';
import 'package:url_launcher/url_launcher.dart';
import 'authentification42.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  // void loginFunction() async {
  //   final oauth2Client = Oauth2Client42();
  //
  //   try {
  //     final authorizationUrl = Uri.parse(
  //         'https://api.intra.42.fr/oauth/authorize?client_id=${dotenv.env["CLIENT_UID"]}&redirect_uri=${dotenv.env["URI42"]}&response_type=code&scope=public&state=marandomstringtest');
  //
  //     if (await canLaunch(authorizationUrl.toString())) {
  //       await launch(authorizationUrl.toString());
  //     } else {
  //       throw 'Could not launch $authorizationUrl';
  //     }
  //   } catch (e) {
  //     print('Une erreur est survenue lors de l\'authentification: $e');
  //   }
  // }


  void loginFunction() async {
    final oauth2Client = Oauth2Client42();

    // Appelez fetchFiles (vous voudrez peut-être le faire à un moment plus approprié dans votre app)
    try {
      await oauth2Client.fetchFiles();
    } catch (e) {
      print('Une erreur est survenue lors de l\'authentification: $e');
    }

    print(dotenv.env['CLIENT_UID']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: loginFunction,
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).primaryColorLight,
            backgroundColor: Theme.of(context).primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
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
  }
}
