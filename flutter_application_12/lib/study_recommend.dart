import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

class Studyrecommend extends StatefulWidget {
  Studyrecommend({Key? key}) : super(key: key);

  @override
  State<Studyrecommend> createState() => _Studyrecommend();
}

class _Studyrecommend extends State<Studyrecommend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Study how',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
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

      //
    );
  }
}