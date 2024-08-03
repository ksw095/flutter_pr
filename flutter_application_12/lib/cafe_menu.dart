import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

class Cafemenu extends StatefulWidget {
  Cafemenu({Key? key}) : super(key: key);

  @override
  State<Cafemenu> createState() => _CafemenuState();
}

class _CafemenuState extends State<Cafemenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 217, 189, 85),
        title: const Text(
          'Order',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,

        //
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              // _showInfoDialog(context);
            },
          ),
        ],
      ),

      // 한비 작성 코드 ~...
    );
  }
}