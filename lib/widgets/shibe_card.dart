import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ShibeCard extends StatelessWidget {
  const ShibeCard(this.imageUrl, {Key? key}) : super(key: key);
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: CachedNetworkImage(
        memCacheWidth: 360,
        maxWidthDiskCache: 1080,
        placeholder: (context, url) {
          return const Icon(Icons.donut_large);
        },
        imageUrl: imageUrl,
      ),
    );
  }
}
