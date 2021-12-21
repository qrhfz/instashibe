// import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shibagram/api/favorite_hive.dart';
import 'package:shimmer/shimmer.dart';

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
          ),
          IconButton(
              onPressed: () async {
                final cache = DefaultCacheManager();
                final file = await cache.getSingleFile(data.toString());
                Share.shareFiles([file.path]);
              },
              icon: const Icon(Icons.share)),
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
        child: PhotoView(
          backgroundDecoration: BoxDecoration(color: Colors.grey.shade200),
          loadingBuilder: (_, __) => Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade100,
            child: Container(
              color: Colors.grey.shade200,
            ),
          ),
          imageProvider: CachedNetworkImageProvider(data.toString()),
        ),
      ),
    );
  }
}
