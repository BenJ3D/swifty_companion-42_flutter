import 'dart:convert';

class UserSimplified {
  String login;
  String firstName;
  String lastName;
  ImageUserSimplified image;

  UserSimplified({
    required this.login,
    required this.firstName,
    required this.lastName,
    required this.image,
  });

  factory UserSimplified.fromJson(Map<String, dynamic> json) {
    try {
      return UserSimplified(
        login: json['login'] ?? '',
        firstName: json['first_name'] ?? '',
        lastName: json['last_name'] ?? '',
        image: ImageUserSimplified.fromJson(json['image']),
      );
    } catch (e, stackTrace) {
      print('Error parsing UserSimplified: $e');
      print('Stack trace: $stackTrace');
      print('JSON: $json');
      rethrow;
    }
  }
}

class ImageUserSimplified {
  String link;
  ImageVersionsUserSimplified versions;

  ImageUserSimplified({
    required this.link,
    required this.versions,
  });

  factory ImageUserSimplified.fromJson(Map<String, dynamic> json) {
    return ImageUserSimplified(
      link: json['link'] ?? '',
      versions: ImageVersionsUserSimplified.fromJson(json['versions'] ?? ''),
    );
  }
}

class ImageVersionsUserSimplified {
  String large;
  String medium;
  String small;
  String micro;

  ImageVersionsUserSimplified({
    required this.large,
    required this.medium,
    required this.small,
    required this.micro,
  });

  factory ImageVersionsUserSimplified.fromJson(Map<String, dynamic> json) {
    return ImageVersionsUserSimplified(
      large: json['large'] ?? '',
      medium: json['medium'] ?? '',
      small: json['small'] ?? '',
      micro: json['micro'] ?? '',
    );
  }
}

List<UserSimplified> parseUsers(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<UserSimplified>((json) => UserSimplified.fromJson(json))
      .toList();
}
