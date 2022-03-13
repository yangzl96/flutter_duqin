import 'package:duqin/config/app_colors.dart';
import 'package:duqin/utils/util.dart';
import 'package:flutter/material.dart';

class CommonLikeRead extends StatelessWidget {
  final int commentCount;
  final int thumbUpCount;
  final int readCount;
  const CommonLikeRead(
      {Key? key,
      required this.commentCount,
      required this.thumbUpCount,
      required this.readCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _iconText('assets/images/icons/comment.png', commentCount),
        _iconText('assets/images/icons/like.png', thumbUpCount),
        _iconText('assets/images/icons/read.png', readCount),
      ],
    );
  }

  _iconText(String icon, int count) {
    return Expanded(
        child: Row(
      children: [
        Image.asset(
          icon,
          width: 18,
          height: 18,
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          child: Text(
            formatCharCount(count),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: AppColors.unactive, fontSize: 12),
          ),
        )
      ],
    ));
  }
}
