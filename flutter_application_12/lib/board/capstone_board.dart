import 'package:flutter/material.dart';
import '../post_screen.dart';

class CapstoneBoard extends StatefulWidget {
  @override
  _CapstoneBoardState createState() => _CapstoneBoardState();
}

class _CapstoneBoardState extends State<CapstoneBoard> {
  List<Map<String, String>> posts = []; // 게시물 목록

  void _addPost(String title, String content) { 
    final post = {
      'title': title,
      'content': content,
      'time': DateTime.now().toLocal().toString().substring(0, 16), // 게시 시간 추가
    };
    setState(() {
      posts.add(post);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 95, 98, 101),
        title: const Text(
          '캡스톤 디자인 게시판',
          style: TextStyle(
              color: Colors.white, fontSize: 20.0, fontFamily: 'Cafe24'),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.home, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('검색')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.post_add_outlined, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PostScreen(onPost: _addPost)), // 글쓰기 화면으로 이동
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft, // 왼쪽 정렬
          ),
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return ListTile(
                  title: Text(
                    post['title']!,
                    style: TextStyle(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 82, 78, 78)),
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '${post['content']!}\n${post['time']!}',
                    overflow: TextOverflow.ellipsis,
                  ),
                  isThreeLine: true,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${post['title']} 클릭')),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}