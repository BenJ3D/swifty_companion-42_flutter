import 'package:flutter/material.dart';
import '../domain/user/User42.dart';

class MainProfile extends StatelessWidget {
  const MainProfile({
    super.key,
    required this.userSelected,
  });

  final User42 userSelected;

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
                  userSelected.image.versions.medium,
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
            userSelected.login,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.left,
          ),
          Text(
            userSelected.email,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.left,
          ),
          Text(
            userSelected.firstName ?? '',
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.left,
          ),
          Text(
            "Year: ${userSelected.poolYear}",
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.left,
          ),
          Text(
            userSelected.cursusUsers.isNotEmpty
                ? "Level: ${userSelected.cursusUsers[0].level}"
                : "Level information not available",
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
