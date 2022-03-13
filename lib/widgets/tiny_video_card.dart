import 'package:duqin/models/video_model.dart';
import 'package:duqin/widgets/avatar_role_name.dart';
import 'package:duqin/widgets/comment_like_read.dart';
import 'package:flutter/material.dart';

class TinyVidoCard extends StatelessWidget {
  final VideoItem? videoItem;
  const TinyVidoCard({Key? key, this.videoItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        cover(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: AvatarRoleName(
            coverPictureUrl: videoItem!.coverPictureUrl,
            nickname: videoItem!.user.nickname,
            type: videoItem!.user.type,
          ),
        ),
        CommonLikeRead(
            commentCount: videoItem!.commentCount,
            thumbUpCount: videoItem!.thumbUpCount,
            readCount: videoItem!.readCount)
      ],
    );
  }

  Widget cover() {
    return AspectRatio(
        aspectRatio: 9 / 16,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/common/lazy-3.png',
                image: videoItem!.coverPictureUrl,
                fit: BoxFit.cover,
              ),
            ),
            Center(
                child: Image.asset(
              'assets/images/icons/play_plus.png',
              width: 38,
              height: 38,
            ))
          ],
        ));
  }
}
