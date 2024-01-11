import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uas/api/getData.dart';

Center ListCategories(
    {
    required  noISBN,
      required  namaPengarang,
      required  tglCetak,
      required  kondisi,
      required  harga,
      required  jenis,
      required  hargaProduksi,
      required btnDelete
      }) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Container(
        width: 350,
        height: 350,
        decoration: BoxDecoration(
            color: Colors.blueGrey, borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.only(top: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 35, right: 35),
                child: Text(
                  'noISBN: $noISBN',
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
                  'Nama Pengarang: $namaPengarang',
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
                  'tanggal Produksi : ${DateFormat('dd MMM yyyy').format(DateTime.parse(tglCetak.toString()))}',
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
                  'Kondisi : $kondisi',
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
                  'harga: $harga',
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
                  'Jenis : $jenis',
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
                  'Harga Produksi: $hargaProduksi',
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
                      fetchDatas().deleteDataById(itemId!);
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


