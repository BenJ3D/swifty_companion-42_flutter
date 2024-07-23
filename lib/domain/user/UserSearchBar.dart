import 'User.dart';

class UserSearchBar {
  final List<User> users;

  UserSearchBar({required this.users});

  factory UserSearchBar.fromJson(List<dynamic> json) {
    List<User> users = json.map((e) => User.fromJson(e)).toList();
    return UserSearchBar(users: users);
  }
}
