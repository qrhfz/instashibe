import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shibagram/pages/favorites.dart';
import 'package:shibagram/pages/home.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              padding: EdgeInsets.zero,
              child: Container(
                color: Theme.of(context).primaryColor,
              )),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => Get.off(() => Home(), popGesture: true),
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorite Shibes'),
            onTap: () => Get.off(() => Favorites(), popGesture: true),
          )
        ],
      ),
    );
  }
}
