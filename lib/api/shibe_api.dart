import 'package:dio/dio.dart';

class ShibeApi {
  final dio = Dio();

  Future getShibe() async {
    try {
      final res = await dio.get(
          'https://shibe.online/api/shibes?count=10&urls=true&httpsUrls=true');

      return res.data;
    } on Exception catch (_) {
      rethrow;
    }
  }
}
