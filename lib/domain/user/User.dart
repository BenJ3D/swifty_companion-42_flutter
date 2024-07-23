class User {
  final int id;
  final String login;
  final String displayName;
  final String kind;
  final UserImage image;
  final bool isStaff;
  final String poolYear;

  User({
    required this.id,
    required this.login,
    required this.displayName,
    required this.kind,
    required this.image,
    required this.isStaff,
    required this.poolYear,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      login: json['login'],
      displayName: json['displayname'],
      kind: json['kind'],
      image: UserImage.fromJson(json['image']),
      isStaff: json['staff?'] ?? false,
      poolYear: json['pool_year'],
    );
  }
}

class UserImage {
  final String link;
  final ImageVersions versions;

  UserImage({
    required this.link,
    required this.versions,
  });

  factory UserImage.fromJson(Map<String, dynamic> json) {
    return UserImage(
      link: json['link'],
      versions: ImageVersions.fromJson(json['versions']),
    );
  }
}

class ImageVersions {
  final String large;
  final String medium;
  final String small;
  final String micro;

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
