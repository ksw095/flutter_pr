// import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

class MyInfoPage extends StatelessWidget {
  MyInfoPage({super.key});

  String myName = '김한성';
  String myEmail = 'kimhs@hansung.ac.kr';
  int myGrade = 22;
  String my1Track = '모바일소프트웨어';
  String my2Track = '디지털콘텐츠&가상현실';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          '내 정보',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
          ),
        ),
        centerTitle: true,

        // 문의
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        '새 UI에 필요한 정보 작성.\n예) 이름, 이메일, 학번, 트랙 정보는 수정이 불가합니다.')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 10),
            imageProfile(context),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  myName,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  ' ($myGrade학번)', //•
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Text(
                  myEmail,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),

            const SizedBox(height: 10),

            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '1 ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: my1Track,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '2 ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: my2Track,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {},
            //   child: const Text('내 정보 수정하기'),
            // ), // 처음에 입력한 정보는 수정 불가능하게 하기 ?

            const SizedBox(height: 10),
            const Divider(
              color: Colors.black,
            ), // 구분선
            const SizedBox(height: 10),

            _buildListTile(
              context,
              icon: Icons.article,
              text: '내가 쓴 글',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('작성한 글이 없습니다.')),
                );
              },
            ),
            const Divider(), // 구분선
            _buildListTile(
              context,
              icon: Icons.comment,
              text: '댓글 단 글',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('작성한 댓글이 없습니다.')),
                );
              },
            ),
            const Divider(), // 구분선
            _buildListTile(
              context,
              icon: Icons.bookmark,
              text: '저장한 글',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('저장한 글이 없습니다.')),
                );
              },
            ),

            const SizedBox(height: 10),
            const Divider(
              color: Colors.black,
            ), // 구분선
            const SizedBox(height: 10),

            _buildListTile(
              context,
              icon: Icons.exit_to_app,
              text: '탈퇴하기',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('현재는 탈퇴할 수 없습니다.')),
                );
              },
              textColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget imageProfile(BuildContext context) {
    return Stack(
      children: <Widget>[
        const CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/images/user.jpg'),
        ),
        Positioned(
          bottom: 10,
          right: 15,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet(context)),
              );
            },
            child: const Icon(
              Icons.camera_alt,
              color: Colors.black,
              size: 35,
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                onPressed: () {
                  // takePhoto(ImageSource.camera);
                },
                icon: const Icon(
                  Icons.image_search,
                  size: 40,
                ),
                label: const Text(
                  '갤러리',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(width: 20),
              TextButton.icon(
                onPressed: () {
                  // takePhoto(ImageSource.gallery);
                },
                icon: const Icon(Icons.delete, size: 40),
                label: const Text(
                  '사진 삭제',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildListTile(BuildContext context,
    {required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color? textColor}) {
  return ListTile(
    leading:
        Icon(icon, color: textColor ?? Theme.of(context).colorScheme.primary),
    title: Text(text, style: TextStyle(color: textColor ?? Colors.black)),
    onTap: onTap,
    // contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
  );
}
