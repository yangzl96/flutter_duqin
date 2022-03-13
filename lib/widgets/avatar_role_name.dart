import 'package:duqin/config/app_colors.dart';
import 'package:duqin/utils/userType.dart';
import 'package:flutter/material.dart';

class AvatarRoleName extends StatelessWidget {
  final String coverPictureUrl;
  final String nickname;
  final bool showType;
  final String? type;
  final double avatarSize;

  AvatarRoleName(
      {Key? key,
      required this.coverPictureUrl,
      required this.nickname,
      this.showType = true,
      this.avatarSize = 25,
      this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _avatar(),
        showType ? _role() : const Text(''),
        _nickName(),
      ],
    );
  }

  _avatar() {
    return SizedBox(
      width: avatarSize,
      height: avatarSize,
      child: ClipOval(
        child: FadeInImage.assetNetwork(
            placeholder: 'assets/images/common/lazy-1.png',
            fit: BoxFit.cover,
            image: coverPictureUrl),
      ),
    );
  }

  _nickName() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 6),
        child: Text(
          nickname,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: AppColors.unactive, fontSize: 14),
        ),
      ),
    );
  }

  _role() {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      decoration: BoxDecoration(
          color: UserType.formColor(type!),
          borderRadius: BorderRadius.circular(4)),
      child: Text(
        UserType.formCn(type!),
        style: const TextStyle(color: Colors.white, fontSize: 10),
      ),
    );
  }
}
