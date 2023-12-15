import 'package:dio/dio.dart';

class fetchDatas {
  Future<List<dynamic>> getdatas() async {
    final result = await Dio().get('http://192.168.111.38:9000/api/v1/cms/bem');

    final datas = result.data;
    print(datas);

    return datas;
  }
}
