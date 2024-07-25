import 'UserSimplified.dart';

class UserSearchBar {
  List<UserSimplified> users;

  UserSearchBar({required this.users});

  factory UserSearchBar.fromJson(List<dynamic> json) {
    List<UserSimplified> users =
        json.map((e) => UserSimplified.fromJson(e)).toList();
    return UserSearchBar(users: users);
  }
}
