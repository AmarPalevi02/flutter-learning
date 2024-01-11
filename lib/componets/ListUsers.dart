import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uas/api/getData.dart';

Center ListUsers(
    {
    required img,
    required nama,
    required alamat,
    required tglDaftar,
    required noTelpon,
    required btnDelete}) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Container(
        width: 350,
        height: 650,
        decoration: BoxDecoration(
            color: Colors.blueGrey, borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.only(top: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 280,
                  height: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(img),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 35, right: 35),
                child: Text(
                  'Nama: $nama',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                child: Text(
                  'alamat: $alamat',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                child: Text(
                  'tanggal beli : ${DateFormat('dd MMM yyyy').format(DateTime.parse(tglDaftar.toString()))}',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                child: Text(
                  'Nomor Telpon : $noTelpon',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              
              ElevatedButton(
                  onPressed: () {
                      int? itemId = int.tryParse('$btnDelete');
                      fetchDatas().deleteDataUser(itemId!);
                      // setState(() {});
                  },
                  child: Text('Hapus'))
            ],
          ),
        ),
      ),
    ),
  );
}


