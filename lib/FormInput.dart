import 'package:flutter/material.dart';

class FormInput extends StatefulWidget {
  const FormInput({super.key});

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  String? _value;
  String? _prodi;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
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
                decoration: InputDecoration(
                    labelText: 'Kode', hintText: 'Masukan Kode Buku'),
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
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value!;
                          print(_value);
                        });
                      }),
                  Text('Baik'),
                  Radio(
                      value: 'Rusak',
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value!;
                          print(_value);
                        });
                      }),
                  Text('Rusak'),
                ],
              ),
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
              TextField(
                decoration: InputDecoration(
                    labelText: 'Judul', hintText: 'Masukan Judul Buku'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
