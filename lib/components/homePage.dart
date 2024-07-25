import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:swifty_companion/domain/user/UserSearchBar.dart';
import 'package:swifty_companion/domain/user/UserSimplified.dart';

import '../domain/user/User42.dart';
import '../services/TokenInterceptor.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User42 userSelected;
  late List<UserSimplified> usersSuggestion;
  late UserSearchBar usersSuggestion2;
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
      poolYear: '',
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
    fetchData();
  }

  void fetchData() async {
    try {
      print('TEST FETCH');

      Response response = await dio.get('https://api.intra.42.fr/v2/me');
      print('${response.data['login']}');
      setState(() {
        userSelected = User42.fromJson(response.data);
        print('*******************${userSelected.login}**********************');
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void fetchDataUser(String login) async {
    try {
      print('TEST FETCH USER');

      Response response =
          await dio.get('https://api.intra.42.fr/v2/users/$login');
      print('${response.data['login']}');
      setState(() {
        userSelected = User42.fromJson(response.data);
        print('*******************${userSelected.login}**********************');
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void fetchSuggestion(String login) async {
    try {
      Response response = await dio.get(
          'https://api.intra.42.fr/v2/users?range[login]=$login,${login}z&per_page=5');
      setState(() {
        usersSuggestion2 = UserSearchBar.fromJson(response.data);
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<List<UserSimplified>> getSuggestions(String pattern) async {
    if (pattern.isEmpty) {
      return [];
    }
    try {
      Response response = await dio.get(
        'https://api.intra.42.fr/v2/users',
        queryParameters: {
          'range[login]': '$pattern,${pattern}z',
          'per_page': '5'
        },
      );

      List<UserSimplified> suggestions = (response.data as List)
          .map((userData) => UserSimplified.fromJson(userData))
          .toList();

      return suggestions;
    } catch (e) {
      print('Error fetching suggestions: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final topPadding = MediaQuery.of(context).padding.top;

    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              TypeAheadField<UserSimplified>(
                suggestionsCallback: (pattern) async {
                  return await getSuggestions(pattern);
                },
                itemBuilder: (context, UserSimplified suggestion) {
                  return ListTile(
                    title: Text(suggestion.login),
                    subtitle:
                        Text('${suggestion.firstName} ${suggestion.lastName}'),
                  );
                },
                onSelected: (UserSimplified suggestion) {
                  fetchDataUser(suggestion.login);
                },
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.topLeft,
                      colors: [Colors.blueGrey.shade900, Colors.black],
                      radius: 4,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: orientation == Orientation.portrait
                            ? topPadding + 0
                            : 0),
                    child: TabBarView(
                      children: <Widget>[
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.3),
                                      spreadRadius: 20,
                                      blurRadius: 40,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: SizedBox(
                                    width: 300,
                                    height: 300,
                                    child: Image.network(
                                      userSelected.image.versions.medium,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
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
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return Image.asset(
                                          'lib/assets/placeholder.webp',
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                userSelected.login,
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                userSelected.email,
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                userSelected.firstName ?? '',
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "Year: ${userSelected.poolYear}",
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                userSelected.cursusUsers.isNotEmpty
                                    ? "Level: ${userSelected.cursusUsers[0].level}"
                                    : "Level information not available",
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () => fetchDataUser(login),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor:
                                      Theme.of(context).primaryColorLight,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
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
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(240, 0, 0, 0),
            ),
            child: const TabBar(
              labelStyle: TextStyle(
                color: Colors.white70,
                fontSize: 20,
              ),
              tabs: [
                Tab(text: 'Profile'),
                Tab(text: 'Cursus'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}