// import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';

class ViewShibe extends StatelessWidget {
  ViewShibe({Key? key}) : super(key: key);
  final dio = Dio();
  final Random random = Random();
  @override
  Widget build(BuildContext context) {
    final data = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('View Shiba'),
        actions: [
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
            placeholder: (context, url) =>
                const Image(image: AssetImage('assets/placeholder.bmp')),
            imageUrl: data.toString(),
          ),
        ),
      ),
    );
  }
}
