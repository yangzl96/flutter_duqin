import 'package:duqin/config/app_colors.dart';
import 'package:duqin/models/user_model.dart';
import 'package:duqin/utils/util.dart';
import 'package:flutter/material.dart';

class SingerCard extends StatelessWidget {
  final UserItem userItem;
  const SingerCard({Key? key, required this.userItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1 / 1,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/common/lazy-1.png',
                  image: userItem.coverPictureUrl,
                  fit: BoxFit.cover)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            userItem.nickname,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: AppColors.active, fontSize: 16),
          ),
        ),
        Row(
          children: [
            _iconText(
                'assets/images/icons/read.png', '歌曲:', userItem.musicCount),
            _iconText(
                'assets/images/icons/read.png', '播放:', userItem.musicPlayCount),
          ],
        )
      ],
    );
  }

  _iconText(String icon, String label, int count) {
    return Expanded(
        child: Row(
      children: [
        Image.asset(
          icon,
          width: 18,
          height: 18,
        ),
        Expanded(
            child: Text(
          label + formatCharCount(count),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: AppColors.unactive, fontSize: 13),
        ))
      ],
    ));
  }
}
