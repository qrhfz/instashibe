import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shibagram/api/shibe_api.dart';
import 'package:shibagram/pages/favorites.dart';
import 'package:shibagram/pages/view_shibe.dart';
import 'package:shibagram/widgets/mydrawer.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final Controller c = Get.put(Controller());
  final scrollController = ScrollController();

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      c.getShibe();
    }
    if (scrollController.offset < scrollController.position.minScrollExtent) {
      Get.defaultDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    c.getShibe();
    scrollController.addListener(_scrollListener);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Shibagram'),
      ),
      drawer: const MyDrawer(),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () => c.refreshShibe(),
          child: StaggeredGridView.builder(
              controller: scrollController,
              itemCount: c.shibes.length,
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                    onTap: () => Get.to(() => ViewShibe(),
                        arguments: c.shibes[index].toString()),
                    child: Card(
                      child: Hero(
                        tag: c.shibes[index].toString(),
                        child: CachedNetworkImage(
                          memCacheWidth: 360,
                          maxWidthDiskCache: 1080,
                          placeholder: (context, url) => const Image(
                              image: AssetImage('assets/placeholder.bmp')),
                          imageUrl: c.shibes[index].toString(),
                        ),
                      ),
                    ),
                  ),
              gridDelegate: SliverStaggeredGridDelegateWithFixedCrossAxisCount(
                staggeredTileCount: c.shibes.length,
                crossAxisCount: 2,
                staggeredTileBuilder: (_) => const StaggeredTile.fit(1),
              )),
        ),
      ),
    );
  }
}

class Controller extends GetxController {
  final shibeApi = ShibeApi();
  RxList shibes = [].obs;
  // ignore: avoid_void_async
  Future<void> refreshShibe() async {
    shibes.clear();
    await getShibe();
  }

  Future<void> getShibe() async {
    try {
      final shibes = await shibeApi.getShibe();

      for (final shibe in shibes) {
        if (!this.shibes.contains(shibe)) {
          this.shibes.add(shibe.toString());
        }
      }
    } on Exception catch (e) {
      Get.defaultDialog(
          title: 'Error', middleText: 'Sorry something is not right');
    }
  }
}
