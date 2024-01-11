import 'package:flutter/material.dart';
import 'package:uas/api/getData.dart';

import 'componets/ListUsers.dart';
import 'componets/ListCategories.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Future<List<Map<String, dynamic>>>? _data;

  void datas() async {
    setState(() {
      // _data = fetchDatas().getDatas();
      _data = fetchDatas().getDatasCategories().then((value) {
        List<Map<String, dynamic>> data =
            value.map((e) => Map<String, dynamic>.from(e)).toList();
        return data;
      });
    });
    setState(() {});
  }


  @override
  void initState() {
    // TODO: implement initState
    datas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print('data: $_data');

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _data,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print('Ini Data ${snapshot.data}');
                  print('images ${snapshot.data}');
                  return Container(
                    width: 400,
                    height: 670,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListCategories(
                            noISBN: snapshot.data![index]['noISBN'],
                            namaPengarang: snapshot.data![index]['namaPengarang'],
                            tglCetak: snapshot.data![index]['tglCetak'],
                            kondisi: snapshot.data![index]['kondisi'],
                            harga: snapshot.data![index]['harga'],
                            jenis: snapshot.data![index]['jenis'],
                            hargaProduksi: snapshot.data![index]['hargaProduksi'],
                            btnDelete: snapshot.data![index]['id']
                            ); 
                      },
                      
                    ),
                  );
                } else {
                  print(snapshot.error);
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
