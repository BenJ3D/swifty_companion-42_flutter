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
    return DropdownMenu<CursusUser>(
      width: screenWidth,
      initialSelection: widget.cursusDefault,
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