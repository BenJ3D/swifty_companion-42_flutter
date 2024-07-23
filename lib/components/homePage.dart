import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../services/TokenInterceptor.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void fetchData() async {
    try {
      print('TEST FETCH');
      final dio = Dio();
      dio.interceptors.add(AuthInterceptor());
      Response response = await dio.get('https://api.intra.42.fr/v2/me');
      print('$response');
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
              const Center(
                child: Text("It's Cursus here"),
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
