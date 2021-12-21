import 'package:get/get.dart';
import 'package:shibagram/api/shibe_api.dart';

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
    } on Exception catch (_) {
      Get.defaultDialog(
          title: 'Error', middleText: 'Sorry something is not right');
    }
  }
}
