import 'dart:convert';

class User42 {
  int id;
  String email;
  String login;
  String firstName;
  String lastName;
  String usualFullName;
  String? usualFirstName;
  String url;
  String displayName;
  bool isStaff;
  int correctionPoint;
  String poolMonth;
  String poolYear;
  String location;
  int wallet;
  DateTime anonymizeDate;
  DateTime dataErasureDate;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? alumnizedAt;
  bool isAlumni;
  bool isActive;
  List<dynamic> groups;
  ImageProfile image;
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
    this.usualFirstName,
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
    this.alumnizedAt,
    required this.isAlumni,
    required this.isActive,
    required this.groups,
    required this.image,
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
    print('Parsing User42 from JSON');
    try {
      return User42(
        id: json['id'],
        email: json['email'] ?? '',
        login: json['login'] ?? '',
        firstName: json['first_name'] ?? '',
        lastName: json['last_name'] ?? '',
        usualFullName: json['usual_full_name'] ?? '',
        usualFirstName: json['usual_first_name'],
        url: json['url'] ?? '',
        displayName: json['displayname'] ?? '',
        isStaff: json['staff?'] ?? false,
        correctionPoint: json['correction_point'] is int
            ? json['correction_point']
            : int.parse(json['correction_point'].toString()),
        poolMonth: json['pool_month'] ?? '',
        poolYear: json['pool_year'],
        location: json['location'] ?? '',
        wallet: json['wallet'] is int
            ? json['wallet']
            : int.parse(json['wallet'].toString()),
        anonymizeDate: json['anonymize_date'] != null
            ? DateTime.parse(json['anonymize_date'])
            : DateTime.now(),
        dataErasureDate: json['data_erasure_date'] != null
            ? DateTime.parse(json['data_erasure_date'])
            : DateTime.now(),
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : DateTime.now(),
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : DateTime.now(),
        alumnizedAt: json['alumnized_at'] != null
            ? DateTime.parse(json['alumnized_at'])
            : null,
        isAlumni: json['alumni?'] ?? false,
        isActive: json['active?'] ?? false,
        groups: List<dynamic>.from(json['groups'] ?? []),
        image: ImageProfile.fromJson(json['image'] ?? {}),
        cursusUsers: (json['cursus_users'] as List<dynamic>?)
                ?.map((x) => CursusUser.fromJson(x))
                .toList() ??
            [],
        projectsUsers: (json['projects_users'] as List<dynamic>?)
                ?.map((x) => ProjectUser.fromJson(x))
                .toList() ??
            [],
        languagesUsers: (json['languages_users'] as List<dynamic>?)
                ?.map((x) => LanguageUser.fromJson(x))
                .toList() ??
            [],
        achievements: (json['achievements'] as List<dynamic>?)
                ?.map((x) => Achievement.fromJson(x))
                .toList() ??
            [],
        titles: (json['titles'] as List<dynamic>?)
                ?.map((x) => Title.fromJson(x))
                .toList() ??
            [],
        titlesUsers: (json['titles_users'] as List<dynamic>?)
                ?.map((x) => TitleUser.fromJson(x))
                .toList() ??
            [],
        campus: (json['campus'] as List<dynamic>?)
                ?.map((x) => Campus.fromJson(x))
                .toList() ??
            [],
        campusUsers: (json['campus_users'] as List<dynamic>?)
                ?.map((x) => CampusUser.fromJson(x))
                .toList() ??
            [],
      );
    } catch (e, stackTrace) {
      print('Error parsing User42: $e');
      print('Stack trace: $stackTrace');
      print('JSON: $json');
      rethrow;
    }
  }
}

class ImageProfile {
  String link;
  ImageVersions versions;

  ImageProfile({
    required this.link,
    required this.versions,
  });

  factory ImageProfile.fromJson(Map<String, dynamic> json) {
    return ImageProfile(
      link: json['link'],
      versions: ImageVersions.fromJson(json['versions']),
    );
  }
}

class ImageVersions {
  String large;
  String medium;
  String small;
  String micro;

  ImageVersions({
    required this.large,
    required this.medium,
    required this.small,
    required this.micro,
  });

  factory ImageVersions.fromJson(Map<String, dynamic> json) {
    return ImageVersions(
      large: json['large'],
      medium: json['medium'],
      small: json['small'],
      micro: json['micro'],
    );
  }
}

class CursusUser {
  String? grade;
  double level;
  List<Skill> skills;
  DateTime? blackholedAt;
  int id;
  DateTime beginAt;
  DateTime? endAt;
  int cursusId;
  bool hasCoalition;
  DateTime createdAt;
  DateTime updatedAt;
  Cursus cursus;

  CursusUser({
    this.grade,
    required this.level,
    required this.skills,
    this.blackholedAt,
    required this.id,
    required this.beginAt,
    this.endAt,
    required this.cursusId,
    required this.hasCoalition,
    required this.createdAt,
    required this.updatedAt,
    required this.cursus,
  });

  factory CursusUser.fromJson(Map<String, dynamic> json) {
    return CursusUser(
      grade: json['grade'],
      level: json['level'].toDouble(),
      skills: List<Skill>.from(json['skills'].map((x) => Skill.fromJson(x))),
      blackholedAt: json['blackholed_at'] != null
          ? DateTime.parse(json['blackholed_at'])
          : null,
      id: json['id'],
      beginAt: DateTime.parse(json['begin_at']),
      endAt: json['end_at'] != null ? DateTime.parse(json['end_at']) : null,
      cursusId: json['cursus_id'],
      hasCoalition: json['has_coalition'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      cursus: Cursus.fromJson(json['cursus']),
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

class Cursus {
  int id;
  DateTime createdAt;
  String name;
  String slug;
  String kind;

  Cursus({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.slug,
    required this.kind,
  });

  factory Cursus.fromJson(Map<String, dynamic> json) {
    return Cursus(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      name: json['name'],
      slug: json['slug'],
      kind: json['kind'],
    );
  }
}

class ProjectUser {
  int id;
  int occurrence;
  int? finalMark;
  String status;
  bool? validated;
  int currentTeamId;
  Project project;
  List<int> cursusIds;
  DateTime? markedAt;
  bool marked;
  DateTime? retriableAt;
  DateTime createdAt;
  DateTime updatedAt;

  ProjectUser({
    required this.id,
    required this.occurrence,
    this.finalMark,
    required this.status,
    this.validated,
    required this.currentTeamId,
    required this.project,
    required this.cursusIds,
    this.markedAt,
    required this.marked,
    this.retriableAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProjectUser.fromJson(Map<String, dynamic> json) {
    return ProjectUser(
      id: json['id'],
      occurrence: json['occurrence'],
      finalMark: json['final_mark'],
      status: json['status'],
      validated: json['validated?'],
      currentTeamId: json['current_team_id'],
      project: Project.fromJson(json['project']),
      cursusIds: List<int>.from(json['cursus_ids'].map((x) => x)),
      markedAt:
          json['marked_at'] != null ? DateTime.parse(json['marked_at']) : null,
      marked: json['marked'],
      retriableAt: json['retriable_at'] != null
          ? DateTime.parse(json['retriable_at'])
          : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class Project {
  int id;
  String name;
  String slug;
  int? parentId;

  Project({
    required this.id,
    required this.name,
    required this.slug,
    this.parentId,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      parentId: json['parent_id'],
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
  int? nbrOfSuccess;
  String usersUrl;

  Achievement({
    required this.id,
    required this.name,
    required this.description,
    required this.tier,
    required this.kind,
    required this.visible,
    required this.image,
    this.nbrOfSuccess,
    required this.usersUrl,
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
      nbrOfSuccess: json['nbr_of_success'],
      usersUrl: json['users_url'],
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
  int languageId;
  String country;
  String address;
  String zip;
  String city;
  String website;
  bool active;
  bool public;
  String emailExtension;
  bool defaultHiddenPhone;

  Campus({
    required this.id,
    required this.name,
    required this.timeZone,
    required this.languageId,
    required this.country,
    required this.address,
    required this.zip,
    required this.city,
    required this.website,
    required this.active,
    required this.public,
    required this.emailExtension,
    required this.defaultHiddenPhone,
  });

  factory Campus.fromJson(Map<String, dynamic> json) {
    return Campus(
      id: json['id'],
      name: json['name'],
      timeZone: json['time_zone'],
      languageId: json['language']['id'],
      country: json['country'],
      address: json['address'],
      zip: json['zip'],
      city: json['city'],
      website: json['website'],
      active: json['active'],
      public: json['public'],
      emailExtension: json['email_extension'],
      defaultHiddenPhone: json['default_hidden_phone'],
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
//   String jsonString = '''{
//     "id": 94576,
//     "email": "bducrocq@student.42lyon.fr",
//     "login": "bducrocq",
//     "first_name": "Benjamin",
//     "last_name": "Ducrocq",
//     "usual_full_name": "Benjamin Ducrocq",
//     "usual_first_name": null,
//     "url": "https://api.intra.42.fr/v2/users/bducrocq",
//     "phone": "hidden",
//     "displayname": "Benjamin Ducrocq",
//     "staff?": false,
//     "correction_point": 5,
//     "pool_month": "august",
//     "pool_year": 2021,
//     "location": "z3r6p6",
//     "wallet": 780,
//     "anonymize_date": "2027-07-24T00:00:00.000+02:00",
//     "data_erasure_date": "2027-07-24T00:00:00.000+02:00",
//     "created_at": "2021-07-29T12:10:13.970Z",
//     "updated_at": "2024-07-24T11:01:21.805Z",
//     "alumnized_at": null,
//     "alumni?": false,
//     "active?": true,
//     "groups": [],
//     "image": {
//         "link": "https://cdn.intra.42.fr/users/20396754573b1890871a5e32487140a6/bducrocq.jpg",
//         "versions": {
//             "large": "https://cdn.intra.42.fr/users/2ec0283d024382785590565152f76b69/large_bducrocq.jpg",
//             "medium": "https://cdn.intra.42.fr/users/f5dc433e0c6e1fcda53775da767f7848/medium_bducrocq.jpg",
//             "small": "https://cdn.intra.42.fr/users/c218c3e8552d09f6303afce6490c4a98/small_bducrocq.jpg",
//             "micro": "https://cdn.intra.42.fr/users/76402209cde33ffb9dce239e657d5690/micro_bducrocq.jpg"
//         }
//     },
//     "cursus_users": [],
//     "projects_users": [],
//     "languages_users": [],
//     "achievements": [],
//     "titles": [],
//     "titles_users": [],
//     "campus": [],
//     "campus_users": []
//   }''';
//
//   Map<String, dynamic> userMap = jsonDecode(jsonString);
//   User user = User.fromJson(userMap);
//
//   // Now you can use the 'user' object in your Flutter app
//   print(user.image.link);  // prints: https://cdn.intra.42.fr/users/20396754573b1890871a5e32487140a6/bducrocq.jpg
// }
