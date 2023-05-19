import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shibagram/pages/favorites.dart';
import 'package:shibagram/pages/home.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: Image.asset(
              'assets/banner.jpg',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => Get.to(() => Home()),
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorite Shibes'),
            onTap: () => Get.to(() => const Favorites()),
          )
        ],
      ),
    );
  }
}
