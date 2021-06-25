import 'dart:developer';

import 'package:hive/hive.dart';

class FavController {
  final Box box = Hive.box('box');

  FavController() {
    if (box.get('favs') == null) {
      box.put('favs', []);
    }
  }

  void addFav(String url) {
    log('Add A Shibe to Favourite');
    final List favs = box.get('favs') as List;
    favs.add(url);
    box.put('favs', favs);
  }

  void removeFav(String url) {
    final List favs = box.get('favs') as List;
    favs.removeWhere((shibeUrl) => shibeUrl == url);
    box.put('favs', favs);
  }

  List getAllFav() {
    return box.get('favs') as List;
  }

  bool isFav(String url) {
    final List favs = box.get('favs') as List;
    log("Is $url is favorite : ${favs.contains(url)}");
    return favs.contains(url);
  }
}
