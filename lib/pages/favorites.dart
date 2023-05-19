import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shibagram/api/favorite_hive.dart';
import 'package:shibagram/pages/view_shibe.dart';
import 'package:shibagram/widgets/shibe_card.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  final FavController c = Get.put(FavController());
  List? shibes;
  final scrollController = ScrollController();

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      c.getAllFav();
    }
    if (scrollController.offset < scrollController.position.minScrollExtent) {
      Get.defaultDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    shibes = c.getAllFav().reversed.toList();

    scrollController.addListener(_scrollListener);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Favorite Shibes'),
      ),
      body: StaggeredGridView.builder(
        controller: scrollController,
        itemCount: shibes?.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => Get.to(
              () => const ViewShibe(),
              arguments: shibes![index].toString(),
            )!
                .then((_) {
              setState(() {
                shibes = c.getAllFav();
              });
            }),
            child: ShibeCard(shibes![index].toString()),
          );
        },
        gridDelegate: SliverStaggeredGridDelegateWithFixedCrossAxisCount(
          staggeredTileCount: shibes!.length,
          crossAxisCount: 2,
          staggeredTileBuilder: (_) => const StaggeredTile.fit(1),
        ),
      ),
    );
  }
}
