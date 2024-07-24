import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../domain/user/User42.dart';
import '../services/TokenInterceptor.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User42 userSelected;
  late String login = 'login';

  void fetchData() async {
    try {
      print('TEST FETCH');
      final dio = Dio();
      dio.interceptors.add(AuthInterceptor());
      Response response = await dio.get('https://api.intra.42.fr/v2/me');
      print('$response');
      setState(() {
        // userSelected.login = 'bducrocq';
        // userSelected.
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: TabBarView(
            children: <Widget>[
              Center(
                child: Column(
                  children: [
                    AppBar(),
                    Text(
                      userSelected.login,
                      textAlign: TextAlign.start,
                    ),
                    ClipOval(
                      clipBehavior: Clip.antiAlias,
                      child: SizedBox(
                        width: 300,
                        height: 300, // Hauteur fixe
                        child: Image.network(
                          'https://cdn.intra.42.fr/users/0396754573b1890871a5e32487140a6/bducrocq.jpg',
                          fit: BoxFit.cover, // Conserve le ratio de l'image
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Image.asset(
                                'lib/assets/placeholder.webp',
                                fit: BoxFit.cover,
                              );
                            }
                          },
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Image.asset(
                              'lib/assets/placeholder.webp',
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: fetchData,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Theme.of(context).primaryColorLight,
                        backgroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child: const Text(
                        'TEST FETCH',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: const TabBar(
            tabs: [
              Tab(text: 'Profile'),
              Tab(text: 'Cursus'),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const HomePage());
}
