import 'package:dio/dio.dart';

class ShibeApi {
  final dio = Dio();

  Future<List<String>> getShibe() async {
    final res = await dio.get(
      'https://shibe.online/api/shibes?count=25&urls=true&httpsUrls=true',
    );

    return (res.data as List).cast();
  }
}
