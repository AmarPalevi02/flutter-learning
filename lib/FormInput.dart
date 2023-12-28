import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uas/api/getData.dart';

class FormInput extends StatefulWidget {
  const FormInput({super.key});

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  String? _kondisi;
  String? _kode = '';
  String? _judul = '';
  String? _prodi;
  DateTime? _tglBeli;
  String? _jenis;
  File? _selectedImage;
  String? _filename;

  int imageId = 80;

  Future _pickImageFromGallerry() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = File(returnImage!.path);
      _filename = p.basename(_selectedImage!.path);
      print('Selected Image: $_selectedImage');
      print('Filename: $_filename');
    });
  }

  TextEditingController kodeBukuController = TextEditingController();
  TextEditingController JudulBukuController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 60, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tambah Categories Buku',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextField(
                  controller: kodeBukuController,
                  decoration: InputDecoration(
                    labelText: 'Kode',
                    hintText: 'Masukan Kode Buku',
                  ),
                ),
                TextField(
                  controller: JudulBukuController,
                  decoration: InputDecoration(
                    labelText: 'Judul',
                    hintText: 'Masukan Judul Buku',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Kondisi',
                  ),
                ),
                Row(
                  children: <Widget>[
                    Radio(
                        value: 'Baik',
                        groupValue: _kondisi,
                        onChanged: (value) {
                          setState(() {
                            _kondisi = value!;
                            print(_kondisi);
                          });
                        }),
                    Text('Baik'),
                    Radio(
                        value: 'Rusak',
                        groupValue: _kondisi,
                        onChanged: (value) {
                          setState(() {
                            _kondisi = value!;
                            print(_kondisi);
                          });
                        }),
                    Text('Rusak'),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: _tglBeli ?? DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now())
                          .then((date) {
                        setState(() {
                          _tglBeli = date!;
                          print(_tglBeli);
                        });
                      });
                    },
                    child: Text('Masukan Tanggal Beli')),
                DropdownButtonFormField<String>(
                  value: _prodi,
                  onChanged: (value) {
                    setState(() {
                      _prodi = value!;
                      print(_prodi);
                    });
                  },
                  items: <String>[
                    'Teknik Mesin',
                    'Teknik Industri',
                    'Teknik Informatika',
                    'Teknik Sipil'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Prodi'),
                ),
                DropdownButtonFormField<String>(
                  value: _jenis,
                  onChanged: (value) {
                    setState(() {
                      _jenis = value!;
                      print(_jenis);
                    });
                  },
                  items: <String>[
                    'Fiksi',
                    'Non-Fiksi',
                    'Ensiklopedia',
                    'Referensi',
                    'Pengembangan'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Jenis Buku'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _pickImageFromGallerry();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Center(
                    child: Text(
                      'Pilih Dari Galery',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                _selectedImage != null
                    ? Image.file(_selectedImage!)
                    : Text('Pilih image'),
                ElevatedButton(
                  onPressed: () {
                    fetchDatas().uploadImage(_selectedImage!);
                  },
                  child: Text('Upload image'),
                ),
                ElevatedButton(
                    onPressed: () {
                      fetchDatas().uploadImages(_selectedImage!);
                      fetchDatas().createCategories(
                          imageId,
                          kode: kodeBukuController.text,
                          judul: JudulBukuController.text,
                          kondisi: _kondisi,
                          prodi: _prodi,
                          tglBeli: _tglBeli.toString(),
                          jenis: _jenis);
                    },

                    // onPressed: () async {
                    //   try {
                    //     // Step 1: Upload Image
                    //     Response responseImage =
                    //         await fetchDatas().uploadImagess(_selectedImage!);

                    //     if (responseImage.statusCode == 200) {
                    //       // Step 2: Get the image ID
                    //       int imageId = responseImage.data['image']['id'];

                    //       // Step 3: Create Category
                    //       Response responseCategory = await fetchDatas().createCategoriye(
                    //         imageId,
                    //         kode: kodeBukuController.text,
                    //         judul: JudulBukuController.text,
                    //         kondisi: _kondisi,
                    //         prodi: _prodi,
                    //         tglBeli: _tglBeli.toString(),
                    //         jenis: _jenis,
                    //       );

                    //       if (responseCategory.statusCode == 200) {
                    //         print('Category created successfully');
                    //       } else {
                    //         print(
                    //             'Failed to create category. Status code: ${responseCategory.statusCode}');
                    //       }
                    //     } else {
                    //       print(
                    //           'Failed to upload image. Status code: ${responseImage.statusCode}');
                    //     }
                    //   } catch (error) {
                    //     print('Error: $error');
                    //     // Handle the error, show a message to the user, etc.
                    //   }
                    // },
                    child: Text('ADD')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
