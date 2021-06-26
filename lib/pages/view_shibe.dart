// import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shibagram/api/favorite_hive.dart';

class ViewShibe extends StatefulWidget {
  const ViewShibe({Key? key}) : super(key: key);

  @override
  _ViewShibeState createState() => _ViewShibeState();
}

class _ViewShibeState extends State<ViewShibe> {
  final dio = Dio();
  bool isFav = false;
  final Random random = Random();

  @override
  Widget build(BuildContext context) {
    final data = Get.arguments;
    final favController = FavController();
    setState(() {
      isFav = favController.isFav(data.toString());
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Shibe'),
        actions: [
          IconButton(
            onPressed: () {
              isFav
                  ? favController.removeFav(data.toString())
                  : favController.addFav(data.toString());
              setState(() {
                isFav = !isFav;
              });
            },
            icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
            color: Colors.red,
          ),
          IconButton(
              onPressed: () async {
                if (await Permission.storage.request().isGranted) {
                  const dir = '/storage/emulated/0/Download';
                  dio.download(
                      data.toString(), '$dir/${random.nextInt(10000)}.jpg');
                }

                // final dir = (await getApplicationDocumentsDirectory()).path;
              },
              icon: const Icon(Icons.download))
        ],
      ),
      body: Center(
        child: Hero(
          tag: data.toString(),
          child: CachedNetworkImage(
            width: double.infinity,
            fit: BoxFit.contain,
            // memCacheWidth: 360,
            maxWidthDiskCache: 1080,
            placeholder: (context, url) =>
                const Image(image: AssetImage('assets/placeholder.jpg')),
            imageUrl: data.toString(),
          ),
        ),
      ),
    );
  }
}
