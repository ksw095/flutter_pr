import 'package:flutter/material.dart';

class BoardScreen extends StatelessWidget {
  final List<String> posts;

  BoardScreen({required this.posts});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    posts[index],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
