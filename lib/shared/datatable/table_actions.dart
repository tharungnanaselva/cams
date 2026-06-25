import 'package:cams/shared/datatable/actions.dart';
import 'package:flutter/material.dart';

class TableActionMenu extends StatelessWidget {
  final List<TableAction> actions;

  const TableActionMenu({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<TableAction>(
      icon: const Icon(Icons.more_vert),

      onSelected: (value) {
        value.onTap();
      },

      itemBuilder: (_) {
        return actions.map((action) {
          return PopupMenuItem(
            value: action,

            child: Row(
              children: [
                Icon(action.icon),

                const SizedBox(width: 10),

                Text(action.title),
              ],
            ),
          );
        }).toList();
      },
    );
  }
}
