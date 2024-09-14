import 'package:flutter/material.dart';

import 'menu_item.dart';

class DrawerView extends StatelessWidget {
  final List<MenuItem> items;
  const DrawerView({super.key, required this.items, required this.changeView});
  final Function changeView;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.separated(
        itemBuilder: (context, index) {
          if (index == 0) {
            return const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Text(
                'OMDB Hermann-Jude',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            );
          } else {
            return ListTile(
              title: Text(items[index - 1].name),
              onTap: () {
                changeView(items[index - 1].view);
                Navigator.pop(context);
              },
            );
          }
        },
        itemCount: items.length + 1,
        separatorBuilder: (context, index) {
          if (index == 0) {
            return const SizedBox.shrink();
          } else {
            return const Divider();
          }
        },
      ),
    );
  }
}
