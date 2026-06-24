import 'package:cams/menu/widgets/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationPanel extends StatelessWidget {
  final Widget child;
  final String currentRoute;

  const NavigationPanel({
    super.key,
    required this.child,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    if (isDesktop) {
      return Scaffold(
        body: Row(
          children: [
            SizedBox(width: 250, child: _Sidebar(currentRoute: currentRoute)),

            Expanded(child: child),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('CAMS')),

      drawer: Drawer(child: _Sidebar(currentRoute: currentRoute)),

      body: child,
    );
  }
}

class _Sidebar extends StatelessWidget {
  final String currentRoute;

  const _Sidebar({required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const DrawerHeader(
          child: Center(child: Text('CAMS', style: TextStyle(fontSize: 24))),
        ),

        ...MenuItems.items.map((item) {
          final selected = item.route == currentRoute;

          return ListTile(
            selected: selected,

            leading: Icon(item.icon),

            title: Text(item.title),

            onTap: () {
              Get.offNamed(item.route);
            },
          );
        }),
      ],
    );
  }
}
