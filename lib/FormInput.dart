import 'dart:io';
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
  String? _noISBN;
  String? _namaPengarang;
  DateTime? _tglCetak;
  String? _kondisi;
  int? _harga;
  String? _jenis;
  int? _hargaProduksi;
  

  TextEditingController noISBNController = TextEditingController();
  TextEditingController NamaPengarangController = TextEditingController();
  TextEditingController HargaControler = TextEditingController();
  TextEditingController HargaProduksiControler = TextEditingController();



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
                  controller: noISBNController,
                  decoration: InputDecoration(
                    labelText: 'noISBN',
                    hintText: 'Masukan noISBN',
                  ),
                ),
                TextField(
                  controller: NamaPengarangController,
                  decoration: InputDecoration(
                    labelText: 'Nama Pengarang',
                    hintText: 'Nama Pengarang',
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: _tglCetak ?? DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now())
                          .then((date) {
                        setState(() {
                          _tglCetak = date!;
                          print(_tglCetak);
                        });
                      });
                    },
                    child: Text('Masukan Tanggal Cetak')),
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
                TextField(
                  controller: HargaControler,
                  decoration: InputDecoration(
                    labelText: 'Harga',
                    hintText: 'Masukan Harga',
                  ),
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
                  TextField(
                  controller: HargaProduksiControler,
                  decoration: InputDecoration(
                    labelText: 'Harga produksi',
                    hintText: 'Masukan Harga produksi',
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      fetchDatas().createCategories(
                          noISBN: noISBNController.text,
                          namaPengarang: NamaPengarangController.text,
                          tglCetak: _tglCetak.toString(),
                          kondisi: _kondisi,
                          harga: HargaControler.text,
                          jenis: _jenis,
                          hargaProduksi: HargaProduksiControler.text
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
