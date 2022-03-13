import 'package:duqin/config/app_colors.dart';
import 'package:duqin/models/video_model.dart';
import 'package:duqin/utils/util.dart';
import 'package:duqin/widgets/avatar_role_name.dart';
import 'package:duqin/widgets/comment_like_read.dart';
import 'package:flutter/material.dart';

const double paddingSize = 20;

class VideoCard extends StatelessWidget {
  final VideoItem videoItem;
  const VideoCard({Key? key, required this.videoItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(paddingSize),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(),
          const SizedBox(
            height: paddingSize,
          ),
          _cover(),
          const SizedBox(
            height: paddingSize,
          ),
          _bottom()
        ],
      ),
    );
  }

  Widget _title() {
    return Text(
      videoItem.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 16, color: AppColors.active),
    );
  }

  Widget _cover() {
    return AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/common/lazy-2.png',
                  image: videoItem.coverPictureUrl,
                  fit: BoxFit.cover),
            ),
            Center(
              child: Image.asset(
                'assets/images/icons/play_plus.png',
                width: 60,
                height: 60,
              ),
            ),
            Positioned(
                right: 10,
                bottom: 10,
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      secondsToTime(videoItem.contentSeconds),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    )))
          ],
        ));
  }

  Widget _bottom() {
    return Row(children: [
      Expanded(
        child: AvatarRoleName(
            type: videoItem.user.type,
            coverPictureUrl: videoItem.user.coverPictureUrl,
            nickname: videoItem.user.nickname),
      ),
      Expanded(
        child: CommonLikeRead(
            commentCount: videoItem.commentCount,
            thumbUpCount: videoItem.thumbUpCount,
            readCount: videoItem.readCount),
      )
    ]);
  }
}
