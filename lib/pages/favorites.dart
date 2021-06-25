import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shibagram/api/favorite_hive.dart';
import 'package:shibagram/pages/view_shibe.dart';
import 'package:shibagram/widgets/mydrawer.dart';

class Favorites extends StatefulWidget {
  Favorites({Key? key}) : super(key: key);

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
    shibes = c.getAllFav();
    scrollController.addListener(_scrollListener);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Shibagram'),
      ),
      drawer: const MyDrawer(),
      body: StaggeredGridView.builder(
        controller: scrollController,
        itemCount: shibes!.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () =>
                Get.to(() => ViewShibe(), arguments: shibes![index].toString())!
                    .then((_) {
              setState(() {
                shibes = c.getAllFav();
              });
            }),
            child: Card(
              child: Hero(
                tag: shibes![index].toString(),
                child: CachedNetworkImage(
                  memCacheWidth: 360,
                  maxWidthDiskCache: 1080,
                  placeholder: (context, url) =>
                      const Image(image: AssetImage('assets/placeholder.bmp')),
                  imageUrl: shibes![index].toString(),
                ),
              ),
            ),
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

// class FavPageController extends GetxController {
//   Box favs = Hive.box('favs');
//   RxList shibes = [].obs;
//   // ignore: avoid_void_async
//   Future<void> refreshShibe() async {
//     shibes.clear();
//     await getShibe();
//   }

//   Future<void> getShibe() async {
//     try {
//       int x = 0;
//       while (favs.getAt(x) != null) {
//         shibes.add(favs.getAt(x));
//         x++;
//       }
//     } on Exception catch (e) {
//       Get.defaultDialog(
//           title: 'Error', middleText: 'Sorry something is not right');
//     }
//   }
// }
