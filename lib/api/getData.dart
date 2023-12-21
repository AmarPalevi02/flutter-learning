import 'package:dio/dio.dart';

class fetchDatas {
  Future<List<Map<String, dynamic>>> getDatas() async {
    final result =
        await Dio().get('http://192.168.111.38:9000/api/v1/cms/draftCategories');

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
