import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../domain/user/User42.dart';

class DropdownMenuCursus extends StatefulWidget {
  final List<CursusUser> options;
  final ValueChanged<CursusUser> onChanged;
  final CursusUser cursusDefault;

  const DropdownMenuCursus(
      {super.key,
      required this.options,
      required this.onChanged,
      required this.cursusDefault});

  @override
  State<DropdownMenuCursus> createState() => _DropdownMenuCursusState();
}

class _DropdownMenuCursusState extends State<DropdownMenuCursus> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Orientation orientation = MediaQuery.of(context).orientation;
    return DropdownMenu<CursusUser>(
      width:
          orientation == Orientation.portrait ? screenWidth : screenWidth / 3,
      initialSelection: widget.cursusDefault,
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        fillColor: Colors.transparent,
        filled: true,
        contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
      ),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(
            Colors.white), // Couleur de fond du menu déroulé
      ),
      textStyle: const TextStyle(color: Colors.white),
      onSelected: (CursusUser? value) {
        setState(() {
          widget.onChanged(value!);
        });
      },
      dropdownMenuEntries:
          widget.options.map<DropdownMenuEntry<CursusUser>>((CursusUser value) {
        return DropdownMenuEntry<CursusUser>(
            value: value, label: value.cursus.name);
      }).toList(),
    );
  }
}
