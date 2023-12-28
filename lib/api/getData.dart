import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

class fetchDatas {
  Future<List<Map<String, dynamic>>> getDatas() async {
    final result =
        await Dio().get('http://192.168.20.38:9000/api/v1/cms/draftCategories');

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
        await Dio().get('http://192.168.20.38:9000/api/v1/cms/categories');
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

  Future addBook({
    required final goodOrBad,
    required final kode,
    required final judul,
    required final prodi,
    required final tglBeli,
    required final jenis,
    required String kondisi,
  }) async {
    try {
      // Pemeriksaan nol untuk memastikan nilai tidak null
      String? formattedDate = tglBeli.toString();
      String? kondisi = goodOrBad.toString();

      if (kode == null ||
          judul == null ||
          prodi == null ||
          goodOrBad == null ||
          tglBeli == null ||
          jenis == null) {
        print('Parameter cannot be null');
        return;
      }

      FormData formData = FormData.fromMap({
        'kBuku': kode,
        'judul': judul,
        'tglBeli': formattedDate,
        'kondisi': goodOrBad,
        'prodi': prodi,
        'jenis': jenis,
      });

      await Dio().post('http://192.168.20.38:9000/api/v1/cms/categories',
          data: formData);

      print('Book added successfully');
    } catch (e) {
      print('Error: $e');
      return e;
    }
  }

  Future<void> uploadImage(File imageFile) async {
    try {
      String filename = imageFile.path.split('/').last;
      String uploadUrl = 'http://192.168.20.38:9000/api/v1/cms/images';

      Dio dio = Dio();
      FormData formData = FormData.fromMap({
        'avatar':
            await MultipartFile.fromFile(imageFile.path, filename: filename),
      });
      Response response = await dio.post(
        uploadUrl,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error uploading image: $error');
    }
  }

  Future<void> uploadImages(File imageFile) async {
    try {
      Dio dio = Dio();
      String filename = imageFile.path.split('/').last;
      String uploadUrl =
          'http://192.168.20.38:9000/api/v1/cms/images'; // Ganti dengan URL upload image di server Anda

      FormData formData = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(
          imageFile.path,
          filename: filename, // Sesuaikan dengan nama file yang diinginkan
        ),
      });

      Response response = await dio.post(
        uploadUrl,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 201) {
        print('Image uploaded successfully');
        // Dapatkan ID gambar dari respons
        var responseData = response.data['data'];
        int imageId = responseData['id'];

        print('image id: $imageId');

        // Selanjutnya, Anda dapat menggunakan imageId untuk membuat objek Categories
        await createCategories(imageId,
            kode: null,
            judul: null,
            kondisi: null,
            jenis: null,
            prodi: null,
            tglBeli: null);
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error uploading image: $error');
    }
  }

// Fungsi untuk membuat objek Categories
  Future<void> createCategories(int imageId,
      {required final kondisi,
      required final kode,
      required final judul,
      required final prodi,
      required final tglBeli,
      required final jenis}) async {
    try {
      Dio dio = Dio();

      String createCategoriesUrl =
          'http://192.168.20.38:9000/api/v1/cms/categories'; 

      Map<String, dynamic> categoriesData = {
        'kBuku': kode, 
        'judul': judul,
        'kondisi': kondisi,
        'jenis': jenis,
        'prodi': prodi,
        'tglBeli': tglBeli,
        'imageId':
            imageId,
      };

      Response response = await dio.post(
        createCategoriesUrl,
        data: categoriesData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 201) {
        print('Categories created successfully');
      } else {
        print(
            'Failed to create categories. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error creating categories: $error');
    }
  }




//============================cobaaa =========================
Future<Response> uploadImagess(File imageFile) async {
  try {
    Dio dio = Dio();
    String filename = imageFile.path.split('/').last;
    String uploadUrl =
        'http://192.168.20.38:9000/api/v1/cms/images';

    FormData formData = FormData.fromMap({
      'avatar': await MultipartFile.fromFile(
        imageFile.path,
        filename: filename, 
      ),
    });

    Response response = await dio.post(
      uploadUrl,
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      ),
    );

    return response; 

  } catch (error) {
    print('Error uploading image: $error');
    throw error; 
  }
}


Future<void> deleteDataById(int id) async {

    try {
      final Dio _dio = Dio();
      final response = await _dio.delete('http://192.168.20.38:9000/api/v1/cms/categories/$id');
      
      if (response.statusCode == 200) {
        print('Data with ID $id deleted successfully');
      } else {
        print('Failed to delete data with ID $id');
      }
    } catch (e) {
      print('Error deleting data: $e');
    }
  }








}
