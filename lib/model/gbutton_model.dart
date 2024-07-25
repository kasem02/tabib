import 'package:flutter/cupertino.dart';

class GButtonModel {
  final IconData? selectedIcon;

  final IconData nonSelectedIcon;

  final int index;

  final String title;

  const GButtonModel(
      {this.selectedIcon,
      required this.index,
      required this.title,
      required this.nonSelectedIcon});
}
