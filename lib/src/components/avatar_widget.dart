import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AvatarType {TYPE1, TYPE2, TYPE3}

class AvatarWidget extends StatelessWidget {
  final AvatarType type;
  final double? size;
  final bool? hasStory;
  final String? nickname;
  final String thumbPath;
  const AvatarWidget({required this.type, this.size=65, this.hasStory, this.nickname, required this.thumbPath, Key? key}) : super(key: key);

  Widget Type1Widget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.purple, Colors.orange]
        ),
        shape: BoxShape.circle
      ),
      child: Type2Widget(),
    );
  }
  Widget Type2Widget() {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size!),
        child: SizedBox(
          width: size,
          height: size,
          child: CachedNetworkImage(
            imageUrl: thumbPath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
  Widget Type3Widget() {
    return Row(
      children: [
        Type1Widget(),
        Text(nickname ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AvatarType.TYPE1 :
        return Type1Widget();
      case AvatarType.TYPE2 :
        return Type2Widget();
      case AvatarType.TYPE3 :
        return Type3Widget();
    }
  }
}
