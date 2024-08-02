import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  final Function(String, String) onPost;

  PostScreen({required this.onPost});

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _submitPost() { // 게시 버튼을 눌렀을 때
    if (_titleController.text.isNotEmpty && _contentController.text.isNotEmpty) {
      widget.onPost(_titleController.text, _contentController.text);
      Navigator.pop(context);
    } else { // 제목과 내용을 입력하지 않은 경우
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('제목과 내용을 입력해주세요.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 95, 98, 101),
        title: const Text(
          '글쓰기',
          style: TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: 'DOSGothic'),
        ),
        centerTitle: true,
        actions: <Widget>[
          TextButton(
            onPressed: _submitPost,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                '게시',
                style: TextStyle(
                  color: Color.fromARGB(255, 95, 98, 101),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: '제목',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  hintText: '내용',
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
                expands: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
