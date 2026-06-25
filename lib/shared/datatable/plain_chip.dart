import 'package:flutter/material.dart';

class PlainStatusBadge extends StatelessWidget {
  final String status;

  const PlainStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(status, style: TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}
