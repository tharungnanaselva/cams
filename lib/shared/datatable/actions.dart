import 'package:flutter/material.dart';

class TableAction {
  final String title;

  final IconData icon;

  final VoidCallback onTap;

  const TableAction({
    required this.title,

    required this.icon,

    required this.onTap,
  });
}
