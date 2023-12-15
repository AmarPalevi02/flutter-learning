import 'package:flutter/material.dart';
import 'package:uas/api/getData.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<dynamic>>? _data;

  void datas() async {
    setState(() {
      _data = fetchDatas().getdatas();
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
        body: Container(),
      ),
    );
  }
}
