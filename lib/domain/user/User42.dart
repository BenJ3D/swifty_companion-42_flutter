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
        correctionPoint: int.tryParse(json['correction_point'].toString()) ?? 0,
        poolMonth: json['pool_month'] ?? '',
        poolYear: json['pool_year'] ?? '',
        location: json['location'] ?? '',
        wallet: int.tryParse(json['wallet'].toString()) ?? 0,
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
        projectsUsers: (json['projects_users'] as List?)
                ?.whereType<Map<String, dynamic>>()
                .map((x) => ProjectUser.fromJson(x))
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
      link: json['link'] ?? '',
      versions: ImageVersions.fromJson(json['versions'] ?? {}),
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
      large: json['large'] ?? '',
      medium: json['medium'] ?? '',
      small: json['small'] ?? '',
      micro: json['micro'] ?? '',
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
      level: (json['level'] as num?)?.toDouble() ?? 0.0,
      skills: (json['skills'] as List<dynamic>?)
              ?.map((x) => Skill.fromJson(x))
              .toList() ??
          [],
      blackholedAt: json['blackholed_at'] != null
          ? DateTime.parse(json['blackholed_at'])
          : null,
      id: json['id'] ?? 0,
      beginAt: json['begin_at'] != null
          ? DateTime.parse(json['begin_at'])
          : DateTime.now(),
      endAt: json['end_at'] != null ? DateTime.parse(json['end_at']) : null,
      cursusId: json['cursus_id'] ?? 0,
      hasCoalition: json['has_coalition'] ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      cursus: Cursus.fromJson(json['cursus'] ?? {}),
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
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      level: (json['level'] as num?)?.toDouble() ?? 0.0,
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
      id: json['id'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      kind: json['kind'] ?? '',
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
      id: json['id'] ?? 0,
      occurrence: json['occurrence'] ?? 0,
      finalMark: json['final_mark'],
      status: json['status'] ?? '',
      validated: json['validated?'],
      currentTeamId: json['current_team_id'] ?? 0,
      project: Project.fromJson(json['project'] ?? {}),
      cursusIds: List<int>.from(json['cursus_ids'] ?? []),
      markedAt:
          json['marked_at'] != null ? DateTime.parse(json['marked_at']) : null,
      marked: json['marked'] ?? false,
      retriableAt: json['retriable_at'] != null
          ? DateTime.parse(json['retriable_at'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
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
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      parentId: json['parent_id'] != null
          ? int.tryParse(json['parent_id'].toString())
          : null,
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
      id: json['id'] ?? 0,
      languageId: json['language_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      position: json['position'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
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
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      tier: json['tier'] ?? '',
      kind: json['kind'] ?? '',
      visible: json['visible'] ?? false,
      image: json['image'] ?? '',
      nbrOfSuccess: json['nbr_of_success'],
      usersUrl: json['users_url'] ?? '',
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
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
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
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      titleId: json['title_id'] ?? 0,
      selected: json['selected'] ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
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
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      timeZone: json['time_zone'] ?? '',
      languageId: json['language']?['id'] ?? 0,
      country: json['country'] ?? '',
      address: json['address'] ?? '',
      zip: json['zip'] ?? '',
      city: json['city'] ?? '',
      website: json['website'] ?? '',
      active: json['active'] ?? false,
      public: json['public'] ?? false,
      emailExtension: json['email_extension'] ?? '',
      defaultHiddenPhone: json['default_hidden_phone'] ?? false,
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
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      campusId: json['campus_id'] ?? 0,
      isPrimary: json['is_primary'] ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
    );
  }
}
