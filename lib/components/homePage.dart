import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:swifty_companion/components/DropdownMenuCursus.dart';
import 'package:swifty_companion/domain/user/UserSearchBar.dart';
import 'package:swifty_companion/domain/user/UserSuggestion.dart';

import '../domain/user/User42.dart';
import '../services/TokenInterceptor.dart';
import '../services/TokenService.dart';
import 'mainProfile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dio = Dio();
  final TokenService tokenService = TokenService();
  late User42 userSelected;
  late CursusUser cursusUserSelected;
  late List<UserSuggestion> usersSuggestion;
  late UserSearchBar usersSuggestion2;
  late String login = 'login';

  _HomePageState() {
    dio.interceptors.add(AuthInterceptor());
    userSelected = user42Init();
    cursusUserSelected = cursusUserInit();
    fetchData();
  }

  CursusUser cursusUserInit() {
    return CursusUser(
        level: 0,
        skills: [],
        id: 0,
        beginAt: DateTime.timestamp(),
        cursusId: 0,
        hasCoalition: false,
        createdAt: DateTime.timestamp(),
        updatedAt: DateTime.timestamp(),
        cursus: Cursus(
            createdAt: DateTime.timestamp(),
            id: 0,
            kind: '',
            name: '',
            slug: ''));
  }

  User42 user42Init() {
    return User42(
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
  }

  //Initial login fetch
  void fetchData() async {
    try {
      Response response = await dio.get('https://api.intra.42.fr/v2/me');
      print('${response.data['login']}');
      setState(() {
        userSelected = User42.fromJson(response.data);
        cursusUserSelected = userSelected.cursusUsers.last;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  //Fetch user
  void fetchDataUser(String login) async {
    try {
      Response response =
          await dio.get('https://api.intra.42.fr/v2/users/$login');
      setState(() {
        userSelected = User42.fromJson(response.data);
        cursusUserSelected = userSelected.cursusUsers.last;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  //Resultat des recherches via login
  Future<List<UserSuggestion>> getSuggestions(String pattern) async {
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

      List<UserSuggestion> suggestions = (response.data as List)
          .map((userData) => UserSuggestion.fromJson(userData))
          .toList();
      setState(() {
        usersSuggestion = suggestions;
      });
      return suggestions;
    } catch (e) {
      print('Error fetching suggestions: $e');
      return [];
    }
  }

  void _deleteTokenDBG() {
    tokenService.deleteToken();
  }

  void _deleteRefreshTokenDBG() {
    tokenService.deleteRefreshToken();
  }

  void _printTokenInfoDBG() async {
    tokenService.printTokenInfo();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final topPadding = MediaQuery.of(context).padding.top;

    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                searchBarTypeAheadField(),
                Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.topLeft,
                        colors: [Colors.blueGrey.shade900, Colors.black],
                        radius: 4,
                      ),
                    ),
                    //TODO: fixer ca
                    child: DropdownMenuCursus<CursusUser>(
                      options: userSelected.cursusUsers
                          .map((cursusUser) => cursusUser.cursus.name)
                          .toList(),
                      onChanged: (value) =>
                          {print('Cursus value changed $value')},
                    )),
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
                          MainProfile(
                            userSelected: userSelected,
                            cursusUserSelected: cursusUserSelected,
                          ),
                          cursusView(context),
                          debugView(context),
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
                  Tab(text: 'DebugApp'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TypeAheadField<UserSuggestion> searchBarTypeAheadField() {
    TextEditingController _controller = TextEditingController();
    return TypeAheadField<UserSuggestion>(
      suggestionsCallback: (pattern) async {
        return await getSuggestions(pattern);
      },
      builder: (context, controller, focusNode) {
        _controller = controller;
        return TextField(
          maxLength: 8,
          style: const TextStyle(color: Colors.blueGrey),
          onSubmitted: (String value) {
            if (usersSuggestion.isNotEmpty &&
                userSelected.login.toString() != usersSuggestion.first.login) {
              setState(() {
                fetchDataUser(usersSuggestion.first.login);
                controller.clear();
              });
            }
          },
          controller: controller,
          focusNode: focusNode,
          autofocus: false,
          decoration: const InputDecoration(
              labelText: 'Search for a 42 login..',
              labelStyle: TextStyle(color: Colors.grey)),
        );
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
        fetchDataUser(suggestion.login);
        FocusScope.of(context).unfocus();
        _controller.clear();
      },
    );
  }

  Center cursusView(BuildContext context) {
    return const Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [],
      ),
    );
  }

  Center debugView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          dbgTokenButtonPrintExpire(context),
          const SizedBox(
            height: 20,
          ),
          dbgTokenButton(context),
          const SizedBox(
            height: 20,
          ),
          dbgRefreshTokenButton(context)
        ],
      ),
    );
  }

  ElevatedButton dbgTokenButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _deleteTokenDBG(),
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
        'DELETE TOKEN',
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  ElevatedButton dbgRefreshTokenButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _deleteRefreshTokenDBG(),
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
        'DELETE REFRESH TOKEN',
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  ElevatedButton dbgTokenButtonPrintExpire(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _printTokenInfoDBG(),
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
        'PRINT TOKEN INFO',
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  dbgDeleteToken() async {
    tokenService.deleteToken();
    String? token = await tokenService.getToken();
    String? refreshToken = await tokenService.getRefreshToken();
    print(token);
    print(refreshToken);
  }
}
