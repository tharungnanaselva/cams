import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final bool active;

  const StatusBadge({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

      decoration: BoxDecoration(
        color: active ? Colors.green.shade100 : Colors.red.shade100,

        borderRadius: BorderRadius.circular(20),
      ),

      child: Text(
        active ? 'Active' : 'Inactive',

        style: TextStyle(
          color: active ? Colors.green.shade800 : Colors.red.shade800,

          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
