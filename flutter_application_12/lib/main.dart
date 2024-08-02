import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_application_pr/board/contest_board.dart';
import 'package:url_launcher/url_launcher.dart';
import 'board/contest_board.dart';
import 'board/academy_board.dart';
import 'board/capstone_board.dart';
import 'board/activiy_board.dart';
import 'info.dart';
import 'cafe.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COM:IN',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 1, 76, 146),
          primary: const Color.fromARGB(255, 1, 76, 146),
          onPrimary: Colors.white,
          secondary: const Color.fromARGB(255, 1, 76, 146).withOpacity(0.7),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 1, 76, 146),
          foregroundColor: Colors.white, // Text color in AppBar
        ),
      ),
      home: AnimatedSplashScreen(
        splash: Image.asset(
          'assets/images/logo01.jpg',
        ),
        splashIconSize: 180,
        nextScreen: const MyHomePage(
          //
          title: 'demo',
        ),
        splashTransition: SplashTransition.fadeTransition,
        duration: 2000,
      ),
      debugShowCheckedModeBanner: false, // 디버그 띠 없애기
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String myName = '김한성';
  bool _isMessageVisible = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _launchUrl(String url) async { // url 유효한지 확인
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _onNavTextTap() {
    _launchUrl('https://www.hansung.ac.kr/onestop/8952/subview.do'); // 클릭 시 상베 예약 화면
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 76, 146),
        title: const Text(
          'COM IN',
          style: TextStyle(
              color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        //
        leading: IconButton(
          icon: const Icon(Icons.home, color: Colors.white),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('홈 화면입니다.')),
            );
          },
        ),

        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('알림이 없습니다.')),
              );
            },
          ),
          IconButton(
            // 앱 바 옆 햄버그 버튼
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer(); // 햄버그바 drawer 열기
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        // 햄버그바 열면 나오는 메뉴
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: const Text(
                    '메뉴',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('내 정보'),
              onTap: () {
                _scaffoldKey.currentState?.closeEndDrawer();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyInfoPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('설정'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('새 UI : 테마, 알림, 비밀번호 설정 등')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('로그아웃'),
              onTap: () {
                _showLogoutDialog(context);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10),
            if (_isMessageVisible)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  // color: Theme.of(context).colorScheme.surfaceContainer,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            myName,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            ' 학우님, 환영합니다!',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '한성대학교 컴퓨터공학과 재학생이라면 COM: IN !\n다양한 기능들을 보다 편리하게 이용해보세요.',
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isMessageVisible = false;
                            });
                          },
                          child: const Icon(
                            Icons.close,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (_isMessageVisible)
              const Divider(
                color: Colors.black,
              ),
            const SizedBox(height: 10), //
            SizedBox(
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _buildFeatureButton(
                    icon: Icons.group,
                    label: '팀원 구인',
                    onTap: () {
                      // Handle tap
                    },
                  ),
                  _buildFeatureButton(
                    icon: Icons.meeting_room,
                    label: '스터디 룸',
                    onTap: () {
                      // Handle tap
                    },
                  ),
                  _buildFeatureButton(
                    icon: Icons.local_cafe,
                    label: '카페 O:TT',
                    onTap: () {
                      // Handle tap
                    },
                  ),
                  _buildFeatureButton(
                    icon: Icons.person,
                    label: '지도 교수',
                    onTap: () {
                      // Handle tap
                    },
                  ),
                  _buildFeatureButton(
                    icon: Icons.school,
                    label: '추천 공부',
                    onTap: () {
                      // Handle tap
                    },
                  ),
                  _buildFeatureButton(
                    icon: Icons.library_books,
                    label: '시험 후기',
                    onTap: () {
                      // Handle tap
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              color: Color.fromARGB(255, 186, 196, 209),
              thickness: 3,
              indent: 15,
              endIndent: 15,
            ),

            // 여기서부터는 컨텐츠
            // 게시물 카드 (캡스톤 디자인, 교내 프로젝트, 교외 프로젝트, 스터디, 동아리, 학술소모임)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  child: Text(
                    '    팀원 구인 게시판',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('전체 게시물에서 검색합니다.')),                          
                    );
                  },
                  child: const Row(
                    children: [
                      Text(
                        '전체 검색',
                        style: TextStyle(fontSize: 13),
                      ),
                      Icon(Icons.search, size: 13),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ), //
            SizedBox(
              height: 190,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _buildContentCard(
                    title: '캡스톤 디자인', // 희망 연도 -> 트랙 선택 후 게시물 작성 (인원)
                    content:
                        '...\n\n...\n\n...\n\n• 최신글 4개', // '예)\n - 25-1 • 2명 • 프론트\n - 25-2 • 1명 • 백', // 최신 글 4개
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CapstoneBoard()),
                      );
                    },
                  ),
                  _buildContentCard(
                    title: '교내외 대회',
                    content: '...\n\n...\n\n...\n\n• 최신글 4개',
                  onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ContestBoard()),
                      );
                    },
                  ),
                  _buildContentCard(
                    title: '교외 활동', // \n(공모전&대외활동)
                    content:
                        '...\n\n...\n\n...\n\n• 최신글 4개', // '예)\n - 공모전 • 2명 • 무관\n - 공모전 • 1명 • 백\n - 대외활동 • 3명 • 백',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ActivityBoard()),
                      );
                    },
                  ),
                  _buildContentCard(
                    title: '교내 학술 모임',
                    content: '...\n\n...\n\n...\n\n• 최신글 4개',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AcademyBoard()),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Divider(
              color: Color.fromARGB(255, 186, 196, 209),
              indent: 15,
              endIndent: 15,
            ),
            const SizedBox(height: 10),

            // 맞춤 추천 공부
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '    맞춤 추천 공부',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                // IconButton(
                //     onPressed: () {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         const SnackBar(
                //             content: Text('콤인 봇과 채팅을 통해 공부를 추천받아보세요.')),
                //       );
                //     },
                //     icon:
                //         Icon(Icons.help_outline, size: 17, color: Colors.grey)),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('   '),
                Container(
                  width: 140, // 이미지의 너비를 적절히 설정하세요.
                  height: 140, // 이미지의 높이
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bot.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('콤인 채팅 봇 페이지로 이동합니다.')),
                      );
                      // 원하는 페이지로 이동 - navigator.push
                    },
                    child: Container(
                      width: double.infinity,
                      height: 110, // 박스 높이 조정
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 13),
                          Text(
                            '  현재 몇 학기 마치셨나요?',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: 'DOSGothic',
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '  콤인이 지금 하기 좋은\n  공부를 추천해 드릴게요..',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              //fontFamily: 'DOSGothic',
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            '  >> 추천 받으러 가기',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: 'DOSGothic',
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(
              color: Color.fromARGB(255, 186, 196, 209),
              indent: 15,
              endIndent: 15,
            ),

            // 카페 O:TT
            const SizedBox(height: 10),

            const Row(
              children: [
                Text(
                  '    카페',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            GestureDetector(
              // InkWell하면 누른 효과가 생김
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CafePage()),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('카페 O:TT 페이지로 이동합니다.')),
                );
                // 원하는 페이지로 이동 - navigator.push
              },
              child: SizedBox(
                height: 220, // 적절한 높이 조정
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 200, // 박스 높이 조정
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/ottlogo.jpg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: const Color.fromARGB(255, 217, 189, 85),
                          width: 5,
                        ), // 사진 테두리
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          color: Colors.black.withOpacity(0.5),
                          child: const Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(
                                '\n카페 O:TT, 오늘 뭐 마실까?',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 5),
                              Text(
                                '최다 주문 메뉴와 추천 메뉴를 확인해보세요!',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '\n바로 가기 >',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),
            const Divider(
              color: Color.fromARGB(255, 186, 196, 209),
              indent: 15,
              endIndent: 15,
            ),

            // 상상베이스
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  '    상상 베이스',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // 간격 줄이기
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              '상상관 지하 1층에 위치한 학업 시설입니다.\n예약을 통해 3-5인이 스터디룸으로 사용 가능합니다.')),
                    );
                  },
                  child: const Icon(Icons.help_outline,
                      size: 17, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 10),

            GestureDetector(
              onTap: () {
                _onNavTextTap(); // 클릭 시 상베 예약 학교 사이트 이동
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('상상베이스 예약창으로 이동합니다.')),
                );
              },
              child: Container(
                width: 325,
                padding: const EdgeInsets.symmetric(horizontal: 69, vertical: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _onNavTextTap();
                      },
                      child: const Text(
                        '스터디 룸 예약하러 가기',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 5), // 텍스트와 아이콘 사이 간격
                    const Icon(Icons.calendar_today, color: Colors.white, size: 15),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Divider(
              color: Color.fromARGB(255, 186, 196, 209),
              indent: 15,
              endIndent: 15,
            ),

            // 지도 교수 소개
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  child: Text(
                    '    지도 교수',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('전체 지도 교수 정보를 보여줍니다.')),
                    );
                  },
                  child: const Row(
                    children: [
                      Text(
                        '더 보기',
                        style: TextStyle(fontSize: 13),
                      ),
                      Icon(Icons.keyboard_arrow_right, size: 13),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(
              color: Color.fromARGB(255, 186, 196, 209),
              indent: 15,
              endIndent: 15,
            ),

            // 시험 후기
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  child: Text(
                    '    시험 후기',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('전체 시험 후기 게시물을 최신순으로 보여줍니다.')),
                    );
                  },
                  child: const Row(
                    children: [
                      Text(
                        '더 보기',
                        style: TextStyle(fontSize: 13),
                      ),
                      Icon(Icons.keyboard_arrow_right, size: 13),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(
              color: Color.fromARGB(255, 186, 196, 209),
              indent: 15,
              endIndent: 15,
            ),
          ],
        ),
      ),
    );
  }

  // 팀원 구하기, 열람실 현황 등 기능 버튼
  Widget _buildFeatureButton(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 70,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon,
                size: 30, color: Theme.of(context).colorScheme.secondary),
            const SizedBox(height: 5),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black, // Color.fromARGB(255, 1, 76, 146),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 로그아웃 다이얼로그
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            '로그아웃 하시겠습니까?',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text('예'),
                  onPressed: () {
                    setState(() {
                      myName = 'Guest';
                      // 로그아웃 처리
                    });

                    _scaffoldKey.currentState?.closeEndDrawer(); // 햄버그바 닫기
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                        '로그아웃 되었습니다.',
                      )),
                    );
                  },
                ),
                TextButton(
                  child: const Text('아니오'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // 팀원 게시판 카드
  Widget _buildContentCard(
      {required String title,
      required String content,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Column 내부의 위젯을 왼쪽 정렬
          children: <Widget>[
            Align(
              alignment: Alignment.center, // 제목을 가운데 정렬
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const Divider(), // title과 content 사이에 구분선
            Text(
              content,
              style: TextStyle(
                fontSize: 13,
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

