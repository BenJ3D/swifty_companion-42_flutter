import 'dart:convert';

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
  final dio = Dio();

  _HomePageState() {
    dio.interceptors.add(AuthInterceptor());
    userSelected = User42(
      id: 0,
      email: '',
      login: 'strooper',
      firstName: 'Storm',
      lastName: 'Trooper',
      usualFullName: 'strooper',
      url: '',
      displayName: 'strooper',
      isStaff: false,
      correctionPoint: 0,
      poolMonth: '',
      poolYear: 0,
      location: '',
      wallet: 0,
      anonymizeDate: DateTime.now(),
      dataErasureDate: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isAlumni: false,
      isActive: true,
      groups: [],
      image: ImageProfile(
        link: '',
        versions: ImageVersions(
          large: '',
          medium: '',
          small: '',
          micro: '',
        ),
      ),
      cursusUsers: [],
      projectsUsers: [],
      languagesUsers: [],
      achievements: [],
      titles: [],
      titlesUsers: [],
      campus: [],
      campusUsers: [],
    );
    // fetchData();
  }

  void fetchData() async {
    try {
      print('TEST FETCH');

      Response response = await dio.get('https://api.intra.42.fr/v2/me');
      print('${response.data['login']}');
      setState(() {
        // userSelected = User42.fromJson(response.data);
        userSelected.login = response.data['login'];
        userSelected.image.versions.medium =
            response.data['image']['versions']['large'];
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void testData() {
    setState(() {
      userSelected.login = "BLABLA";
    });
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
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    ClipOval(
                      child: SizedBox(
                        width: 300,
                        height: 300, // Hauteur fixe
                        child: Image.network(
                          userSelected.image.versions.medium,
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
                        'GET ME',
                        style: TextStyle(fontSize: 24),
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
