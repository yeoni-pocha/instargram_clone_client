import 'package:flutter/cupertino.dart';
import 'package:instargram_clone/src/components/avatar_widget.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({Key? key}) : super(key: key);

  Widget _header() {
    return Row(
      children: [
        AvatarWidget(type: AvatarType.TYPE3, thumbPath: 'http://blog.jinbo.net/attach/615/200937431.jpg')
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          _header(),
          // _image(),
          // _infoCount(),
          // _infoDescription(),
          // _replyTextBtn(),
          // _dateAgo(),
        ],
      ),
    );
  }
}
