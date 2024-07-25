import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:swifty_companion/domain/user/UserSearchBar.dart';
import 'package:swifty_companion/domain/user/UserSuggestion.dart';

import '../domain/user/User42.dart';
import '../services/TokenInterceptor.dart';
import 'mainProfile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User42 userSelected;
  late List<UserSuggestion> usersSuggestion;
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

  Future<List<UserSuggestion>> getSuggestions(String pattern) async {
    if (pattern.isEmpty) {
      return [];
    }
    try {
      print('ENTER GET SUGGESTIONS : pattern = **** $pattern ****');
      Response response = await dio.get(
        'https://api.intra.42.fr/v2/users',
        queryParameters: {
          'range[login]': '$pattern,${pattern}z',
          'per_page': '5'
        },
      );

      List<UserSuggestion> suggestions = (response.data as List)
          .map((userData) => UserSuggestion.fromJson(userData))
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
        child: SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                searchBarTypeAheadField(),
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
                          MainProfile(userSelected: userSelected),
                          cursusView(context),
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
      ),
    );
  }

  TypeAheadField<UserSuggestion> searchBarTypeAheadField() {
    return TypeAheadField<UserSuggestion>(
      suggestionsCallback: (pattern) async {
        return await getSuggestions(pattern);
      },
      itemBuilder: (context, UserSuggestion suggestion) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipOval(
                  child: SizedBox(
                      width: 70,
                      height: 70,
                      child: Image.network(
                        fit: BoxFit.cover,
                        suggestion.image.versions.small,
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
                      ))),
              Expanded(
                child: ListTile(
                  title: Text(suggestion.login),
                  subtitle:
                      Text('${suggestion.firstName} ${suggestion.lastName}'),
                ),
              ),
            ],
          ),
        );
      },
      onSelected: (UserSuggestion suggestion) {
        print("PK????******");
        fetchDataUser(suggestion.login);
      },
    );
  }

  Center cursusView(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => fetchDataUser(login),
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
              'TEST FETCH',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}
