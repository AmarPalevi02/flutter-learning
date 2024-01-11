import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uas/api/getData.dart';

class FormInputUser extends StatefulWidget {
  const FormInputUser({super.key});

  @override
  State<FormInputUser> createState() => _FormInputUserState();
}

class _FormInputUserState extends State<FormInputUser> {
  String? _nama;
  String? _alamat;
  DateTime? _tglDaftar;
  String? _noTelpon;

  File? _selectedImage;
  String? _filename;

  int imageId = 13;

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
  

  TextEditingController AlamatController = TextEditingController();
  TextEditingController NamaController = TextEditingController();
  TextEditingController NotelpControler = TextEditingController();



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
                  'Tambah User',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextField(
                  controller: NamaController,
                  decoration: InputDecoration(
                    labelText: 'Nama',
                    hintText: 'Masukan Nama',
                  ),
                ),
                TextField(
                  controller: AlamatController,
                  decoration: InputDecoration(
                    labelText: 'Alamat',
                    hintText: 'Masukan Alamat',
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: _tglDaftar ?? DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now())
                          .then((date) {
                        setState(() {
                          _tglDaftar = date!;
                          print(_tglDaftar);
                        });
                      });
                    },
                    child: Text('Masukan Tanggal Daftar')),
                     TextField(
                  controller: NotelpControler,
                  decoration: InputDecoration(
                    labelText: 'No Telpon',
                    hintText: 'Masukan No Telpon',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Kondisi',
                  ),
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
                      fetchDatas().uploadImages(_selectedImage!);
                      fetchDatas().createUsers(
                          imageId,
                          nama: NamaController.text,
                          alamat: AlamatController.text,
                          tglDaftar: _tglDaftar.toString(),
                          noTelpon: NotelpControler.text,
                          );
                          
                    },
                    child: Text('ADD')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
