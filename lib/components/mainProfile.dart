import 'package:flutter/material.dart';
import '../domain/user/User42.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MainProfile extends StatefulWidget {
  final User42 userSelected;
  final CursusUser cursusUserSelected;
  final bool debugMode;

  const MainProfile({
    super.key,
    required this.userSelected,
    required this.cursusUserSelected,
    required this.debugMode,
  });

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
    double screenWidth = MediaQuery.of(context).size.width;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Center(
              child: Text(
                '${widget.userSelected.firstName} ${widget.userSelected.lastName}',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Center(
            child: Text(
              getTitleLogin(),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white54),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          profilePhoto(),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 3),
            child: Center(
              child: percentageBarLevel(
                  screenWidth, percentageLevelCoeff, level, percentageLevel),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                children: [
                  const SizedBox(
                    width: 9,
                  ),
                  statsCard(
                    screenWidth,
                    Center(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.email_rounded,
                            color: Colors.white,
                            size: 33,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Flexible(
                            child: Text(
                              widget.userSelected.email,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  statsCard(
                    screenWidth,
                    Center(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 33,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            getPrimaryCampusName(),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          const Expanded(
                            child: Text(
                              "Location",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white38),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  widget.userSelected.poolYear != ''
                      ? statsCard(
                          screenWidth,
                          Row(
                            children: [
                              const Icon(
                                Icons.pool,
                                color: Colors.white,
                                size: 33,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                widget.userSelected.poolYear,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              const Expanded(
                                child: Text(
                                  "Pool year",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white38),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                  statsCard(
                    screenWidth,
                    Row(
                      children: [
                        const Icon(
                          Icons.account_balance_wallet,
                          color: Colors.white,
                          size: 33,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          '${widget.userSelected.wallet.toString()} ₳',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Expanded(
                          child: Text(
                            "Wallet",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.white38),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                  statsCard(
                    screenWidth,
                    Row(
                      children: [
                        const Icon(
                          Icons.grade_rounded,
                          color: Colors.white,
                          size: 33,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          widget.cursusUserSelected.grade ?? 'Novice',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Expanded(
                          child: Text(
                            "Grade",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.white38),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                  statsCard(
                    screenWidth,
                    Row(
                      children: [
                        const Icon(
                          Icons.account_balance_sharp,
                          color: Colors.white,
                          size: 33,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "${widget.userSelected.correctionPoint}",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Expanded(
                          child: Text(
                            "Evaluation points",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.white38),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row percentageBarLevel(double screenWidth, double percentageLevelCoeff,
      int level, int percentageLevel) {
    return Row(
      children: [
        LinearPercentIndicator(
          barRadius: const Radius.circular(12),
          lineHeight: 30.0,
          width: screenWidth - 20,
          percent: percentageLevelCoeff,
          center: Text(
            'level: ${level.toString()} - $percentageLevel%',
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: Colors.white),
          ),
          backgroundColor: Colors.blueGrey.shade700,
          progressColor: Colors.blue.shade600,
        ),
      ],
    );
  }

  Container profilePhoto() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: widget.debugMode
                ? Colors.redAccent.withOpacity(0.4)
                : Colors.blueAccent.withOpacity(0.4),
            spreadRadius: 7,
            blurRadius: 8,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Center(
        child: ClipOval(
          child: SizedBox(
            width: 200,
            height: 200,
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
    );
  }

  SizedBox statsCard(double screenWidth, Widget child) {
    return SizedBox(
      width: screenWidth - 10,
      child: Card(
        color: Colors.blueGrey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
          child: child,
        ),
      ),
    );
  }

  String getTitleLogin() {
    int idTitle;
    try {
      idTitle = widget.userSelected.titlesUsers
          .firstWhere((elem) => elem.selected == true)
          .titleId;
    } catch (e) {
      idTitle = -1;
    }
    String title;
    try {
      title = widget.userSelected.titles
          .firstWhere((elem) => elem.id == idTitle)
          .name;
    } catch (e) {
      title = '%login';
    }
    return title.replaceAll('%login', widget.userSelected.login);
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
