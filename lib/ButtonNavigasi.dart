import 'package:flutter/material.dart';
import 'package:uas/FormInput.dart';
import 'package:uas/Home.dart';

class ButtonNavigasi extends StatefulWidget {
  final int initialIndexCard;
  const ButtonNavigasi(
      {Key? key, this.initialIndexCard = 0, })
      : super(key: key);

  @override
  State<ButtonNavigasi> createState() => _ButtonNavigasi();
}

class _ButtonNavigasi extends State<ButtonNavigasi> {
  int _initialIndexCard = 0;
  // late Map<String, String> _movieData;

  void _tappedButton(int index) {
    setState(() {
      _initialIndexCard = index;
    });
  }

  List<Widget> get _ButtonList {
    if (_initialIndexCard == 1) {
      return [
        Home(),
        FormInput(),
      ];
    }
    return [
        Home(),
        FormInput()
    ];
  }

  @override
  void initState() {
    super.initState();
    _initialIndexCard = widget.initialIndexCard;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: _ButtonList.elementAt(_initialIndexCard),
          ),
          BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.movie),
                label: 'Movie',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: _initialIndexCard,
            selectedItemColor: Colors.amber[800],
            onTap: _tappedButton,
          ),
        ],
      ),
    );
  }
}
