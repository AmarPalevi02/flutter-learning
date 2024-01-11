import 'package:flutter/material.dart';
import 'package:uas/api/getData.dart';

import 'componets/ListUsers.dart';

class ShowUsers extends StatefulWidget {
  const ShowUsers({super.key});

  @override
  State<ShowUsers> createState() => _ShowUsersState();
}

class _ShowUsersState extends State<ShowUsers> {
  Future<List<Map<String, dynamic>>>? _data;

  void datas() async {
    setState(() {
      // _data = fetchDatas().getDatas();
      _data = fetchDatas().getDatasUsers().then((value) {
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
                        return ListUsers(
                            img:
                                'http://192.168.20.38:9000/${snapshot.data![index]['image']['fileName']}',
                            nama: snapshot.data![index]['nama'],
                            alamat: snapshot.data![index]['alamat'],
                            tglDaftar: snapshot.data![index]['tglDaftar'],
                            noTelpon: snapshot.data![index]['noTelpon'],
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
