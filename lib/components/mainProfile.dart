import 'package:flutter/material.dart';
import '../domain/user/User42.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MainProfile extends StatefulWidget {
  final User42 userSelected;
  final CursusUser cursusUserSelected;

  const MainProfile({
    Key? key,
    required this.userSelected,
    required this.cursusUserSelected,
  }) : super(key: key);

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
  void didUpdateWidget(covariant MainProfile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.cursusUserSelected != oldWidget.cursusUserSelected) {
      setState(() {
        _currentCursusUser = widget.cursusUserSelected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double getPercentageCoef(double number) {
      return number - number.toInt();
    }

    int getLevel(double number) {
      return number.toInt();
    }

    int getPercentage(double number) {
      return ((getPercentageCoef(number) * 100).round()).toInt();
    }

    final percentageLevelCoeff = getPercentageCoef(_currentCursusUser.level);
    final level = getLevel(_currentCursusUser.level);
    final percentageLevel = getPercentage(_currentCursusUser.level);

    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
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
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.left,
            ),
            Text(
              widget.userSelected.email,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.left,
            ),
            Row(
              children: [
                Text(
                  widget.userSelected.firstName ?? '',
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  width: 9,
                ),
                Text(
                  widget.userSelected.lastName ?? '',
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            Text(
              "Pool year: ${widget.userSelected.poolYear}",
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.left,
            ),
            Text(
              "Grade: ${widget.cursusUserSelected.grade ?? 'Novice'}",
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.left,
            ),
            Text(
              "Evaluation points: ${widget.userSelected.correctionPoint}",
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.left,
            ),
            Row(
              children: [
                LinearPercentIndicator(
                  lineHeight: 25.0,
                  width: 300.0,
                  percent: percentageLevelCoeff,
                  center:
                      Text('level: ${level.toString()} - $percentageLevel%'),
                  backgroundColor: Colors.blueGrey,
                  progressColor: Colors.blue.shade600,
                ),
                // Text(
                //   _currentCursusUser.level.toString(),
                //   style: const TextStyle(
                //       fontSize: 24,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.white),
                //   textAlign: TextAlign.left,
                // ),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 33,
                ),
                Text(
                  getPrimaryCampusName(),
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                  size: 33,
                ),
                Text(
                  '${widget.userSelected.wallet.toString()} ₳',
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getPrimaryCampusName() {
    final int primaryCampusId = widget.userSelected.campusUsers
            .firstWhere((elem) => elem.isPrimary == true)
            .campusId ??
        0;
    return widget.userSelected.campus
            .firstWhere((elem) => elem.id == primaryCampusId)
            .name ??
        '';
  }
}
