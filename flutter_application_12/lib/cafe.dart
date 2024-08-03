import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'cafe_menu.dart';

class CafePage extends StatefulWidget {
  const CafePage({super.key});

  @override
  _CafePageState createState() => _CafePageState();
}

class _CafePageState extends State<CafePage> {
  // final List<Map<String, String>> _messages = [];
  final List<String> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode(); // FocusNode 추가
  // final ApiService _apiService = ApiService(
  //     ''); // 내 api key

  void _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      String userMessage = _controller.text;
      setState(() {
        //_messages.add({"role": "user", "message": userMessage});
        _messages.add("User: ${_controller.text}");
        _messages.add("Bot: reply of ${_controller.text} ...");
        _controller.clear();
      });

      // API 요청을 보내고 응답 받기
      // String botResponse = await _apiService.fetchGPT3Response(userMessage);
      // setState(() {
      //   _messages.add({"role": "bot", "message": botResponse});
      // });

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );

      _focusNode.requestFocus(); // 텍스트 필드에 포커스 유지
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _focusNode.dispose(); // FocusNode 해제
    super.dispose();
  }

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

        //
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.location_on, color: Colors.white),
            onPressed: () {
              _showInfoDialog(context);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // 반투명 배경 이미지
          Positioned.fill(
            child: Opacity(
              opacity: 0.2, // 투명도 설정
              child: Image.asset(
                'assets/images/bot.png', // 이미지 경로
                fit: BoxFit.fitWidth,
              ),
            ),
          ),

          Column(
            children: [
              // Non-scrollable part
              Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.grey[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Cafemenu()));
                      },
                      child: const Row(
                        children: [
                          Text(
                            '메뉴 확인 & 주문하기 ',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.keyboard_arrow_right, size: 17),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),

              // 스크롤 가능
              const SizedBox(
                height: 5,
              ),
              Container(
                color: Colors.grey[200],
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '    🤖 O:TT 추천봇',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    bool isUserMessage = _messages[index].startsWith("User:");
                    return Align(
                      alignment: isUserMessage
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: ChatBubble(
                        _messages[index]
                            .replaceFirst("User: ", "")
                            .replaceFirst("Bot: ", ""),
                        isUserMessage: isUserMessage,
                      ),
                    );
                  },
                ),
              ),

              Row(
                children: [
                  const Padding(padding: EdgeInsets.all(5.0)),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '카페에 관해 궁금한 것을 물어보세요.',
                        hintFadeDuration: Duration(milliseconds: 100),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0), // 패딩 조정
                      ),
                      controller: _controller,
                      focusNode: _focusNode, // FocusNode 설정
                      onSubmitted: (text) => _sendMessage(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send,
                        color: Color.fromARGB(255, 217, 189, 85)),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUserMessage;

  ChatBubble(this.message, {required this.isUserMessage, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      decoration: BoxDecoration(
        color: isUserMessage ? Colors.blueGrey : Colors.blue, //Accent,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SelectableText(
        // 텍스트 드래그 가능
        message,
        style: const TextStyle(fontSize: 15.0, color: Colors.white),
      ),
    );
  }
}

// 앱바 옆 버튼을 눌렀을 때 나타나는 다이얼로그
void _showInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        icon: Icon(Icons.location_on, color: Color.fromARGB(255, 217, 189, 85)),
        title: const Text(
          '카페 O:TT는 한성대학교 연구관 1층 \n상상파크 내에 위치해 있습니다.\n운영 시간 : 10:00 ~ 16:00 (주말 휴무)',
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: const Text('확인'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}