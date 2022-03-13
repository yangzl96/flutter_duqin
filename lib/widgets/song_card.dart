import 'package:duqin/config/app_colors.dart';
import 'package:duqin/models/song_model.dart';
import 'package:duqin/utils/util.dart';
import 'package:duqin/widgets/avatar_role_name.dart';
import 'package:duqin/widgets/comment_like_read.dart';
import 'package:flutter/material.dart';

class SongCard extends StatelessWidget {
  final SongItem? songItem;
  const SongCard({Key? key, this.songItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(toRpx(context, 40)),
      child: Row(
        children: [
          _songCover(),
          const SizedBox(
            width: 8,
          ),
          _songContent(),
        ],
      ),
    );
  }

  _songCover() {
    return SizedBox(
      width: 75,
      height: 75,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            // FadeInImage一个懒加载的效果
            // placeholder：图片未加载完时的本地图片
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/common/lazy-1.png',
              image: songItem!.coverPictureUrl,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Image.asset(
              'assets/images/icons/tiny_video.png',
              width: 22,
              height: 22,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  _songContent() {
    return Expanded(
      child: SizedBox(
          height: 75,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    songItem!.cnName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        const TextStyle(color: AppColors.active, fontSize: 16),
                  ),
                  // const SizedBox(height: 10),
                  Text(
                    songItem!.enName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: AppColors.un3active, fontSize: 14),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 110,
                    child: AvatarRoleName(
                      coverPictureUrl: songItem!.user.coverPictureUrl,
                      nickname: songItem!.user.nickname,
                      showType: false,
                      avatarSize: 20,
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: CommonLikeRead(
                        commentCount: songItem!.commentCount,
                        thumbUpCount: songItem!.thumbUpCount,
                        readCount: songItem!.readCount,
                      ))
                ],
              )
            ],
          )),
    );
  }
}
