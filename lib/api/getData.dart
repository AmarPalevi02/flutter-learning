import 'dart:io';

import 'package:dio/dio.dart';

class fetchDatas {
  Future<List<Map<String, dynamic>>> getDatas() async {
    final result =
        await Dio().get('http://192.168.76.38:9000/api/v1/cms/draftCategories');

    if (result.statusCode == 200) {
      final datas = result.data['data'];
      print(datas);
      return datas.cast<Map<String, dynamic>>();
    } else {
      print('Failed to load data');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getDatasCategories() async {
    final result =
        await Dio().get('http://192.168.76.38:9000/api/v1/cms/categories');
    if (result.statusCode == 200) {
      final datas = result.data['data'];

      print(datas);
      return datas.cast<Map<String, dynamic>>();
    }
    if (result.statusCode == 200) {
      final datas = result.data['data']['images'];
      print(datas);
      return datas.cast<Map<String, dynamic>>();
    } else {
      print('Failed to load data');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getDatasImage() async {
    final result =
        await Dio().get('http://192.168.76.38:9000/api/v1/cms/images');
    if (result.statusCode == 200) {
      final datas = result.data['data'];

      print(datas);
      return datas.cast<Map<String, dynamic>>();
    } else {
      print('Failed to load data');
      return [];
    }
  }

  // Future addBook({
  //   // required final goodOrBad,
  //   // required final kode,
  //   // required final judul,
  //   // required final prodi,
  //   // required final tglBeli,
  //   // required final jenis,
  //   required final selectedImage,
  // }) async {
  //   try {
  //     String fileName = selectedImage.path.split('avatar').last;
  //     FormData formData = FormData.fromMap({
  //       // 'kBuku': kode,
  //       // 'judul': judul,
  //       // 'tglBeli': tglBeli,
  //       // 'kondisi': goodOrBad,
  //       // 'prodi': prodi,
  //       // 'jenis': jenis,
  //       'fileName': await MultipartFile.fromFile(selectedImage.path,
  //           filename: fileName),
  //     });

  //     await Dio().post('http://192.168.76.38:9000/api/v1/cms/images',
  //         data: formData);

  //     print(formData);
  //   } catch (e) {
  //     print(e);
  //     return e;
  //   }
  // }

  Future<void> addBook(File imageFile) async {
  try {
    String uploadUrl = 'http://192.168.76.38:9000/api/v1/cms/images'; // Gantilah dengan URL upload server Anda

    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      'fileName': await MultipartFile.fromFile(imageFile.path, filename: 'fileName'),
    });

    Response response = await dio.post(uploadUrl, data: formData);

    if (response.statusCode == 200) {
      print('Image uploaded successfully');
    } else {
      print('Failed to upload image. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error uploading image: $error');
  }
}

}
