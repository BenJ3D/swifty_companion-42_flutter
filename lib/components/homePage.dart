import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:swifty_companion/components/DropdownMenuCursus.dart';
import 'package:swifty_companion/domain/user/UserSearchBar.dart';
import 'package:swifty_companion/domain/user/UserSuggestion.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:swifty_companion/services/NavigatorService.dart';

import '../domain/user/User42.dart';
import '../services/TokenService.dart';
import 'mainProfile.dart';

class HomePage extends StatefulWidget {
  final Dio dio;

  const HomePage({super.key, required this.dio});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TokenService tokenService = TokenService();
  late bool loading = true;
  late User42? userSelected;
  late CursusUser? cursusUserSelected;
  late List<UserSuggestion> usersSuggestion;
  late UserSearchBar usersSuggestion2;
  late int cursusIdDefault = 0;
  late String login = 'login';
  late double level = 0;
  late String grade = 'Novice';

  @override
  void initState() {
    super.initState();
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
      Response response = await widget.dio.get('/v2/me');
      setState(() {
        userSelected = User42.fromJson(response.data);
        cursusUserSelected = userCursusDefaultLogic(userSelected!.cursusUsers);
        setState(() {
          loading = false;
        });
      });
    } catch (e) {
      print('Error: $e');
      NavigatorService().navigateToAndRemoveAll('/login');
    }
  }

  //Fetch user
  void fetchDataUser(String login) async {
    try {
      loading = true;
      Response response = await widget.dio.get('/v2/users/$login');
      setState(() {
        userSelected = User42.fromJson(response.data);
        if (userSelected?.cursusUsers != null) {
          cursusUserSelected =
              userCursusDefaultLogic(userSelected!.cursusUsers);
          setState(() {
            loading = false;
          });
        }
      });
    } catch (e) {
      print('Error: $e');
      NavigatorService().navigateToAndRemoveAll('/login');
    }
  }

  CursusUser userCursusDefaultLogic(List<CursusUser> listCursus) {
    if (listCursus.length == 1) {
      return listCursus.first;
    }
    try {
      return listCursus.firstWhere((elem) => elem.cursusId == 21);
    } catch (e) {
      try {
        return listCursus.firstWhere((elem) => elem.cursusId == 9);
      } catch (e) {
        return listCursus.isEmpty
            ? CursusUser(
                level: 0,
                skills: [],
                id: 0,
                beginAt: DateTime.now(),
                cursusId: 0,
                hasCoalition: false,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
                cursus: Cursus(
                    createdAt: DateTime.now(),
                    id: 0,
                    kind: '',
                    name: '',
                    slug: ''))
            : listCursus.first;
      }
    }
  }

  //Resultat des recherches via login
  Future<List<UserSuggestion>> getSuggestions(String pattern) async {
    if (pattern.isEmpty) {
      return [];
    }
    try {
      Response response = await widget.dio.get(
        '/v2/users',
        queryParameters: {
          'range[login]': '$pattern,${pattern}zz',
          'per_page': '15'
        },
      );

      List<UserSuggestion> suggestions = (response.data as List)
          .map((userData) => UserSuggestion.fromJson(userData))
          .toList()
          .reversed
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
    _printTokenInfoDBG();
  }

  void _deleteRefreshTokenDBG() {
    tokenService.deleteRefreshToken();
    _printTokenInfoDBG();
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
        length: 4, //ACTIVATION DEBUG MENU PASSAGE 3 => 4 ************
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topLeft,
                colors: [Colors.blueGrey.shade900, Colors.black],
                radius: 4,
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: loading == false
                  ? Column(
                      children: [
                        searchBarTypeAheadField(),
                        DropdownMenuCursus(
                          options: userSelected!.cursusUsers,
                          cursusDefault: userCursusDefaultLogic(
                              userSelected?.cursusUsers ?? []),
                          onChanged: (CursusUser value) => {
                            setState(() {
                              cursusUserSelected = value;
                            })
                          },
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: orientation == Orientation.portrait
                                    ? topPadding + 0
                                    : 0),
                            child: TabBarView(
                              children: <Widget>[
                                userSelected != null &&
                                        cursusUserSelected != null
                                    ? SingleChildScrollView(
                                        child: MainProfile(
                                          userSelected: userSelected!,
                                          cursusUserSelected:
                                              cursusUserSelected!,
                                        ),
                                      )
                                    : const Text(''),
                                projectsTab(
                                    context,
                                    userSelected!.projectsUsers
                                        .where((elem) => elem.cursusIds
                                            .contains(
                                                cursusUserSelected!.cursusId))
                                        .toList(),
                                    orientation),
                                skillsTab(context, orientation),
                                debugView(context),
                                //ACTIVATION DEBUG MENU DECOMMENTER ************
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: LoadingAnimationWidget.hexagonDots(
                          color: Colors.blueGrey, size: 200)),
              bottomNavigationBar: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(240, 0, 0, 0),
                ),
                child: const TabBar(
                  indicatorColor: Colors.lightBlueAccent,
                  labelStyle: TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                  ),
                  tabs: [
                    Tab(text: 'Profile'),
                    Tab(text: 'Marks'),
                    Tab(text: 'Skills'),
                    Tab(text: 'DebugApp'),
                    //ACTIVATION DEBUG MENU DECOMMENTER ************
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TypeAheadField<UserSuggestion> searchBarTypeAheadField() {
    bool patternIsEmpty = true;

    TextEditingController _controller = TextEditingController();
    return TypeAheadField<UserSuggestion>(
      suggestionsCallback: (pattern) async {
        if (pattern.isEmpty) {
          patternIsEmpty = true;
          return [];
        }
        patternIsEmpty = false;
        return await getSuggestions(pattern);
      },
      hideOnEmpty: patternIsEmpty,
      builder: (context, controller, focusNode) {
        _controller = controller;
        return TextField(
          maxLength: 8,
          buildCounter: (BuildContext context,
              {int? currentLength, int? maxLength, bool? isFocused}) {
            return null;
          },
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.blue.shade800,
          onSubmitted: (String value) {
            if (usersSuggestion.isNotEmpty &&
                userSelected!.login.toString() != usersSuggestion.first.login) {
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
              contentPadding: EdgeInsets.fromLTRB(12, 22, 12, 4),
              labelText: 'search login...',
              labelStyle: TextStyle(color: Colors.grey)),
        );
      },
      loadingBuilder: (context) => Container(),
      itemBuilder: (context, UserSuggestion suggestion) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Row(
            children: [
              ClipOval(
                  child: SizedBox(
                      width: 42,
                      height: 42,
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

  Center projectsTab(BuildContext context, List<ProjectUser> projectUsers,
      Orientation orientation) {
    final childAspectRatio =
        orientation == Orientation.portrait ? 8 / 6 : 10 / 6;
    final crossAxisCount = orientation == Orientation.portrait ? 2 : 4;
    final double projectNameTxtSize =
        orientation == Orientation.portrait ? 16 : 14;
    final double projectNoteTxtSize =
        orientation == Orientation.portrait ? 20 : 16;

    return projectUsers.isEmpty
        ? const Center(
            child: Text(
              'NO PROJECTS',
              style: TextStyle(color: Colors.white38, fontSize: 40),
            ),
          )
        : Center(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: projectUsers.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount, // Nombre de colonnes
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio:
                    childAspectRatio, // Ajustez ce ratio selon vos besoins
              ),
              itemBuilder: (context, index) {
                ProjectUser projectUser = projectUsers[index];
                return Card(
                  color: projectUser.validated != null
                      ? projectUser.validated == true
                          ? null
                          : Colors.red.shade100
                      : null,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          projectUser.project.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: projectNameTxtSize),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          projectUser.finalMark != null
                              ? '${projectUser.finalMark}'
                              : projectUser.status,
                          style: projectUser.validated == null
                              ? const TextStyle(fontSize: 16)
                              : projectUser.validated == true
                                  ? TextStyle(
                                      fontSize: projectNoteTxtSize,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w400)
                                  : TextStyle(
                                      fontSize: projectNoteTxtSize,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }

  Center skillsTab(BuildContext context, Orientation orientation) {
    final childAspectRatio =
        orientation == Orientation.portrait ? 8 / 6 : 10 / 6;
    final crossAxisCount = orientation == Orientation.portrait ? 2 : 4;
    late List<String> features =
        cursusUserSelected!.skills.map((elem) => elem.name).toList();
    late List<double> data =
        cursusUserSelected!.skills.map((elem) => elem.level).toList();
    return features.isEmpty
        ? const Center(
            child: Text(
            'NO SKILLS',
            style: TextStyle(color: Colors.white38, fontSize: 40),
          ))
        : Center(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: features.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount, // Nombre de colonnes
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio:
                    childAspectRatio, // Ajustez ce ratio selon vos besoins
              ),
              itemBuilder: (context, index) {
                String skill = features[index];
                return Card(
                  color: Colors.blueGrey.shade700,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          skill,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          data[index].toStringAsFixed(2),
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }

  SingleChildScrollView debugView(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
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
}
