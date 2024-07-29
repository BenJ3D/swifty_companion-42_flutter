import 'package:flutter/material.dart';

/// Flutter code sample for [DropdownMenu].

class DropdownMenuCursus extends StatefulWidget {
  final List<String> options;
  final ValueChanged<String> onChanged;

  const DropdownMenuCursus(
      {super.key, required this.options, required this.onChanged});

  @override
  State<DropdownMenuCursus> createState() => _DropdownMenuCursusState();
}

class _DropdownMenuCursusState extends State<DropdownMenuCursus> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: widget.options.first,
      textStyle: const TextStyle(color: Colors.white),
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          widget.onChanged(value!);
        });
      },
      dropdownMenuEntries:
          widget.options.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
