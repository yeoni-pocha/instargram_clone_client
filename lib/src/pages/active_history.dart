import 'package:flutter/material.dart';
import 'package:instargram_clone/src/components/avatar_widget.dart';

class ActiveHistory extends StatelessWidget {
  const ActiveHistory({Key? key}) : super(key: key);

  Widget _activeItemOne() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: const [
          AvatarWidget(
            type: AvatarType.TYPE2,
            size: 40,
            thumbPath: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTD-FPrClXiolofgRtHq_yf7p-K9XyZegxD3dqrYbMSba67vBVVighWoXZeRyOWqFl40FQ&usqp=CAU"
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text.rich(
                TextSpan(
                    text: '여니포차',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(text: '님이 회원님의 게시물을 좋아합니다.', style: TextStyle(fontWeight: FontWeight.normal)),
                      TextSpan(text: ' 5 일전', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13, color: Colors.black54))
                    ]
                ),
              )
          )
        ],
      ),
    );
  }

  Widget _newRecentlyActiveView(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 15),
          _activeItemOne(),
          _activeItemOne(),
          _activeItemOne(),
          _activeItemOne(),
          _activeItemOne()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('활동', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _newRecentlyActiveView('오늘'),
            _newRecentlyActiveView('이번주'),
            _newRecentlyActiveView('이번달')
          ],
        ),
      ),
    );
  }
}
