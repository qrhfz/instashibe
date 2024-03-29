import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shibagram/controller/home_controller.dart';
import 'package:shibagram/pages/about.dart';
import 'package:shibagram/pages/favorites.dart';
import 'package:shibagram/pages/view_shibe.dart';
import 'package:shibagram/widgets/shibe_card.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final Controller c = Get.put(Controller());
  final scrollController = ScrollController();

  void _scrollListener() {
    if (scrollController.offset >=
            scrollController.position.maxScrollExtent * 0.6 &&
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
        title: const Text('Instashibe'),
        actions: [
          IconButton(
            onPressed: () => Get.to(() => const Favorites()),
            icon: const Icon(
              Icons.favorite,
              color: Color(0xffc00000),
            ),
          ),
          PopupMenuButton<int>(
            onSelected: (value) {
              if (value == 1) {
                Get.to(() => const About());
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text('About'),
                )
              ];
            },
          )
        ],
      ),
      // drawer: const MyDrawer(),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () => c.refreshShibe(),
          child: StaggeredGridView.builder(
            controller: scrollController,
            itemCount: c.shibes.length,
            itemBuilder: (BuildContext context, int index) => GestureDetector(
              onTap: () => Get.to(
                () => const ViewShibe(),
                arguments: c.shibes[index],
              ),
              child: ShibeCard(c.shibes[index]),
              // Card(
              //   child: CachedNetworkImage(
              //     memCacheWidth: 360,
              //     maxWidthDiskCache: 1080,
              //     placeholder: (context, url) => const Icon(Icons.donut_large),
              //     imageUrl: c.shibes[index].toString(),
              //   ),
              // ),
            ),
            gridDelegate: SliverStaggeredGridDelegateWithFixedCrossAxisCount(
              staggeredTileCount: c.shibes.length,
              crossAxisCount: 2,
              staggeredTileBuilder: (_) => const StaggeredTile.fit(1),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
          ),
        ),
      ),
    );
  }
}
