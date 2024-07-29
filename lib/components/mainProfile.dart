import 'package:flutter/material.dart';
import '../domain/user/User42.dart';

class MainProfile extends StatefulWidget {
  const MainProfile({
    Key? key,
    required this.userSelected,
    required this.cursusUserSelected,
  }) : super(key: key);

  final User42 userSelected;
  final CursusUser cursusUserSelected;

  @override
  _MainProfileState createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfile> {
  late CursusUser _currentCursusUser;

  @override
  void initState() {
    super.initState();
    _currentCursusUser = widget.cursusUserSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  spreadRadius: 20,
                  blurRadius: 40,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipOval(
              child: SizedBox(
                width: 300,
                height: 300,
                child: Image.network(
                  widget.userSelected.image.versions.large,
                  fit: BoxFit.cover,
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
                ),
              ),
            ),
          ),
          Text(
            widget.userSelected.login,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.left,
          ),
          Text(
            widget.userSelected.email,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.left,
          ),
          Text(
            widget.userSelected.firstName ?? '',
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.left,
          ),
          Text(
            "Year: ${widget.userSelected.poolYear}",
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.left,
          ),
          Text(
            _currentCursusUser.level.toString(),
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
