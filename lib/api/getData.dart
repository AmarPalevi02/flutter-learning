import 'package:dio/dio.dart';

class fetchDatas {
  Future<List<Map<String, dynamic>>> getDatas() async {
    final result =
        await Dio().get('http://192.168.111.38:9000/api/v1/cms/categories');

    if (result.statusCode == 200) {
      final datas = result.data['data'];
      print(datas);
      return datas.cast<Map<String, dynamic>>();
    } else {
      print('Failed to load data');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getImages() async {
    final result =
        await Dio().get('http://192.168.111.38:9000/api/v1/cms/images');

    if (result.statusCode == 200) {
      final datas = result.data['data'];
      print(datas);
      return datas.cast<Map<String, dynamic>>();
    } else {
      print('Failed to load data');
      return [];
    }
  }
}
