import 'package:flutter/material.dart';
import 'package:uas/api/getData.dart';

import 'componets/ListBook.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Map<String, dynamic>>>? _data;

  void datas() async {
    setState(() {
      // _data = fetchDatas().getDatas();
      _data = fetchDatas().getDatas().then((value) {
        List<Map<String, dynamic>> data =
            value.map((e) => Map<String, dynamic>.from(e)).toList();
        return data;
      });
    });
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
                  return Container(
                    width: 400,
                    height: 670,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListBook(
                            img:
                                'http://192.168.111.38:9000/${snapshot.data![index]['fileName']}',
                            kBuku: snapshot.data![index]['kBuku'],
                            judul: snapshot.data![index]['judul'],
                            kondisi: snapshot.data![index]['kondisi'],
                            jenis: snapshot.data![index]['jenis'],
                            prodi: snapshot.data![index]['prodi'],
                            tglBeli: snapshot.data![index]['tglBeli']);
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
