import 'package:flutter/material.dart';

class CafePage extends StatelessWidget {
  CafePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 217, 189, 85),
        title: const Text(
          'Cafe O:tt',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
