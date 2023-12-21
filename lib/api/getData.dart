import 'package:dio/dio.dart';

class fetchDatas {
  Future<List<Map<String, dynamic>>> getDatas() async {
    final result = await Dio()
        .get('http://192.168.111.38:9000/api/v1/cms/draftCategories');

    if (result.statusCode == 200) {
      final datas = result.data['data'];
      print(datas);
      return datas.cast<Map<String, dynamic>>();
    } else {
      print('Failed to load data');
      return [];
    }
  }

  Future addBook({
    required final goodOrBad,
    required final kode,
    required final judul,
    required final prodi,
    required final tglBeli,
    required final jenis,
    required final selectedImage,
  }) async {
    try {
      String fileName = selectedImage.path.split('/').last;
      FormData formData = FormData.fromMap({
        'kBuku': kode,
        'judul': judul,
        'tglBeli': tglBeli,
        'kondisi': goodOrBad,
        'prodi': prodi,
        'jenis': jenis,
        'fileName': await MultipartFile.fromFile(selectedImage.path,
            filename: fileName),
      });

      await Dio().post('http://192.168.76.38/:9000/api/v1/cms/draftCategories',
          data: formData);
    } catch (e) {
      print(e);
      return e;
    }
  }
}
