import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instargram_clone/src/components/avatar_widget.dart';

class ActiveHistory extends StatelessWidget {
  const ActiveHistory({Key? key}) : super(key: key);

  Widget _activeItemOne() {
    return Row(
      children: [
        AvatarWidget(
          type: AvatarType.TYPE2,
          size: 40,
          thumbPath: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTD-FPrClXiolofgRtHq_yf7p-K9XyZegxD3dqrYbMSba67vBVVighWoXZeRyOWqFl40FQ&usqp=CAU"
        ),
        const SizedBox(width: 10),
        Expanded(
            child: Text.rich(
                TextSpan(text: '여니포차님', style: TextStyle(fontWeight: FontWeight.bold)),

            )
        )
      ],
    );
  }

  Widget _newRecentlyActiveView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('오늘', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 15),
          _activeItemOne()
        ],
      ),
    );
  }

  Widget _newRecentlyThisWeekView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('이번주', style: TextStyle(fontSize: 16))
        ],
      ),
    );
  }

  Widget _newRecentlyMonthView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('이번달', style: TextStyle(fontSize: 16))
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
            _newRecentlyActiveView(),
            _newRecentlyThisWeekView(),
            _newRecentlyMonthView()
          ],
        ),
      ),
    );
  }
}
