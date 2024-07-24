import 'dart:convert';

class User42 {
  int id;
  String email;
  String login;
  String firstName;
  String lastName;
  String usualFullName;
  String url;
  String displayName;
  bool isStaff;
  int correctionPoint;
  String poolMonth;
  int poolYear;
  String location;
  int wallet;
  DateTime anonymizeDate;
  DateTime dataErasureDate;
  DateTime createdAt;
  DateTime updatedAt;
  bool isAlumni;
  bool isActive;
  List<CursusUser> cursusUsers;
  List<ProjectUser> projectsUsers;
  List<LanguageUser> languagesUsers;
  List<Achievement> achievements;
  List<Title> titles;
  List<TitleUser> titlesUsers;
  List<Campus> campus;
  List<CampusUser> campusUsers;

  User42({
    required this.id,
    required this.email,
    required this.login,
    required this.firstName,
    required this.lastName,
    required this.usualFullName,
    required this.url,
    required this.displayName,
    required this.isStaff,
    required this.correctionPoint,
    required this.poolMonth,
    required this.poolYear,
    required this.location,
    required this.wallet,
    required this.anonymizeDate,
    required this.dataErasureDate,
    required this.createdAt,
    required this.updatedAt,
    required this.isAlumni,
    required this.isActive,
    required this.cursusUsers,
    required this.projectsUsers,
    required this.languagesUsers,
    required this.achievements,
    required this.titles,
    required this.titlesUsers,
    required this.campus,
    required this.campusUsers,
  });

  factory User42.fromJson(Map<String, dynamic> json) {
    return User42(
      id: json['id'],
      email: json['email'],
      login: json['login'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      usualFullName: json['usual_full_name'],
      url: json['url'],
      displayName: json['displayname'],
      isStaff: json['staff?'],
      correctionPoint: json['correction_point'],
      poolMonth: json['pool_month'],
      poolYear: json['pool_year'],
      location: json['location'],
      wallet: json['wallet'],
      anonymizeDate: DateTime.parse(json['anonymize_date']),
      dataErasureDate: DateTime.parse(json['data_erasure_date']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      isAlumni: json['alumni?'],
      isActive: json['active?'],
      cursusUsers: List<CursusUser>.from(
          json['cursus_users'].map((x) => CursusUser.fromJson(x))),
      projectsUsers: List<ProjectUser>.from(
          json['projects_users'].map((x) => ProjectUser.fromJson(x))),
      languagesUsers: List<LanguageUser>.from(
          json['languages_users'].map((x) => LanguageUser.fromJson(x))),
      achievements: List<Achievement>.from(
          json['achievements'].map((x) => Achievement.fromJson(x))),
      titles: List<Title>.from(json['titles'].map((x) => Title.fromJson(x))),
      titlesUsers: List<TitleUser>.from(
          json['titles_users'].map((x) => TitleUser.fromJson(x))),
      campus: List<Campus>.from(json['campus'].map((x) => Campus.fromJson(x))),
      campusUsers: List<CampusUser>.from(
          json['campus_users'].map((x) => CampusUser.fromJson(x))),
    );
  }
}

class CursusUser {
  String grade;
  double level;
  List<Skill> skills;
  DateTime beginAt;
  DateTime endAt;
  int cursusId;
  bool hasCoalition;

  CursusUser({
    required this.grade,
    required this.level,
    required this.skills,
    required this.beginAt,
    required this.endAt,
    required this.cursusId,
    required this.hasCoalition,
  });

  factory CursusUser.fromJson(Map<String, dynamic> json) {
    return CursusUser(
      grade: json['grade'],
      level: json['level'].toDouble(),
      skills: List<Skill>.from(json['skills'].map((x) => Skill.fromJson(x))),
      beginAt: DateTime.parse(json['begin_at']),
      endAt: DateTime.parse(json['end_at']),
      cursusId: json['cursus_id'],
      hasCoalition: json['has_coalition'],
    );
  }
}

class Skill {
  int id;
  String name;
  double level;

  Skill({
    required this.id,
    required this.name,
    required this.level,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'],
      name: json['name'],
      level: json['level'].toDouble(),
    );
  }
}

class ProjectUser {
  int id;
  int occurrence;
  int finalMark;
  String status;
  bool validated;
  int currentTeamId;
  Project project;

  ProjectUser({
    required this.id,
    required this.occurrence,
    required this.finalMark,
    required this.status,
    required this.validated,
    required this.currentTeamId,
    required this.project,
  });

  factory ProjectUser.fromJson(Map<String, dynamic> json) {
    return ProjectUser(
      id: json['id'],
      occurrence: json['occurrence'],
      finalMark: json['final_mark'] ?? 0,
      status: json['status'],
      validated: json['validated?'] ?? false,
      currentTeamId: json['current_team_id'],
      project: Project.fromJson(json['project']),
    );
  }
}

class Project {
  int id;
  String name;
  String slug;

  Project({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }
}

class LanguageUser {
  int id;
  int languageId;
  int userId;
  int position;
  DateTime createdAt;

  LanguageUser({
    required this.id,
    required this.languageId,
    required this.userId,
    required this.position,
    required this.createdAt,
  });

  factory LanguageUser.fromJson(Map<String, dynamic> json) {
    return LanguageUser(
      id: json['id'],
      languageId: json['language_id'],
      userId: json['user_id'],
      position: json['position'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class Achievement {
  int id;
  String name;
  String description;
  String tier;
  String kind;
  bool visible;
  String image;
  int nbrOfSuccess;

  Achievement({
    required this.id,
    required this.name,
    required this.description,
    required this.tier,
    required this.kind,
    required this.visible,
    required this.image,
    required this.nbrOfSuccess,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      tier: json['tier'],
      kind: json['kind'],
      visible: json['visible'],
      image: json['image'],
      nbrOfSuccess: json['nbr_of_success'] ?? 0,
    );
  }
}

class Title {
  int id;
  String name;

  Title({
    required this.id,
    required this.name,
  });

  factory Title.fromJson(Map<String, dynamic> json) {
    return Title(
      id: json['id'],
      name: json['name'],
    );
  }
}

class TitleUser {
  int id;
  int userId;
  int titleId;
  bool selected;
  DateTime createdAt;
  DateTime updatedAt;

  TitleUser({
    required this.id,
    required this.userId,
    required this.titleId,
    required this.selected,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TitleUser.fromJson(Map<String, dynamic> json) {
    return TitleUser(
      id: json['id'],
      userId: json['user_id'],
      titleId: json['title_id'],
      selected: json['selected'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class Campus {
  int id;
  String name;
  String timeZone;
  String country;
  String address;
  String zip;
  String city;
  String website;
  bool active;
  bool public;

  Campus({
    required this.id,
    required this.name,
    required this.timeZone,
    required this.country,
    required this.address,
    required this.zip,
    required this.city,
    required this.website,
    required this.active,
    required this.public,
  });

  factory Campus.fromJson(Map<String, dynamic> json) {
    return Campus(
      id: json['id'],
      name: json['name'],
      timeZone: json['time_zone'],
      country: json['country'],
      address: json['address'],
      zip: json['zip'],
      city: json['city'],
      website: json['website'],
      active: json['active'],
      public: json['public'],
    );
  }
}

class CampusUser {
  int id;
  int userId;
  int campusId;
  bool isPrimary;
  DateTime createdAt;
  DateTime updatedAt;

  CampusUser({
    required this.id,
    required this.userId,
    required this.campusId,
    required this.isPrimary,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CampusUser.fromJson(Map<String, dynamic> json) {
    return CampusUser(
      id: json['id'],
      userId: json['user_id'],
      campusId: json['campus_id'],
      isPrimary: json['is_primary'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
//
// void main() {
//   String jsonString = '...'; // your JSON string here
//   Map<String, dynamic> userMap = jsonDecode(jsonString);
//   User user = User.fromJson(userMap);
//
//   // Now you can use the 'user' object in your Flutter app
//   print(user.firstName);
// }
