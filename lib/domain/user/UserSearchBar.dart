import 'UserSuggestion.dart';

class UserSearchBar {
  List<UserSuggestion> users;

  UserSearchBar({required this.users});

  factory UserSearchBar.fromJson(List<dynamic> json) {
    List<UserSuggestion> users =
        json.map((e) => UserSuggestion.fromJson(e)).toList();
    return UserSearchBar(users: users);
  }
}
