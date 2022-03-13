import 'package:duqin/config/app_colors.dart';
import 'package:duqin/models/article_model.dart';
import 'package:duqin/utils/util.dart';
import 'package:duqin/widgets/avatar_role_name.dart';
import 'package:duqin/widgets/comment_like_read.dart';
import 'package:flutter/material.dart';

const double paddingSize = 20;
const double spaceSize = 10;

class ArticleCard extends StatefulWidget {
  final ArticleItem articleItem;
  const ArticleCard({Key? key, required this.articleItem}) : super(key: key);

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  late double boxSize; //盒子大小
  @override
  Widget build(BuildContext context) {
    boxSize = MediaQuery.of(context).size.width - paddingSize * 2;
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
          _getCoverByType(),
          const SizedBox(
            height: paddingSize,
          ),
          _bottom()
        ],
      ),
    );
  }

  _title() {
    return Text(
      widget.articleItem.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 16, color: AppColors.active),
    );
  }

  // 图片显示
  // 1张 => 1种
  // 2张 => 2种(左右 上下)
  // 3张 => 6种 (左2右1 左一右二 上一下二 上二下一 | 以两张的格式显示(上下 左右 还有一张点开图片后滑动查看))
  // 4张 => 上面三张的6种(三张图的显示方式，最后一张点开任意一张滑动才可见) + 上下左右各一张
  // 规定随机数 对应显示不同的展现方式 coverType
  // 1张 => 1
  // 2张 => 2,3
  // 3张 => 2,3,4,5,6,7
  // 4张 => 2,3,4,5,6,7,8
  // 根据数量长度获取对应的显示规则
  _getTypeByLength() {
    int length = widget.articleItem.coverUrlList.length;
    int coverType;
    switch (length) {
      case 2:
        coverType = getRandomRangeInt(2, 3);
        break;
      case 3:
        coverType = getRandomRangeInt(2, 7);
        break;
      case 4:
        coverType = getRandomRangeInt(2, 8);
        break;
      default:
        coverType = 1;
    }
    return coverType;
  }

  // 根据对应的规则生成不同的展示
  _getCoverByType() {
    int coverType = _getTypeByLength();
    Widget _coverWidget;
    switch (coverType) {
      case 2:
        _coverWidget = _cover2();
        break;
      case 3:
        _coverWidget = _cover3();
        break;
      case 4:
        _coverWidget = _cover4();
        break;
      case 5:
        _coverWidget = _cover5();
        break;
      case 6:
        _coverWidget = _cover6();
        break;
      case 7:
        _coverWidget = _cover7();
        break;
      case 8:
        _coverWidget = _cover8();
        break;
      default:
        _coverWidget = _cover1();
    }
    return _coverWidget;
  }

  // 1张
  Widget _cover1() {
    return SizedBox(width: boxSize, height: boxSize, child: _cover());
  }

  // 2张 左右
  Widget _cover2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: boxSize / 2 - spaceSize / 2,
            height: boxSize,
            child: _cover(index: 0)),
        SizedBox(
            width: boxSize / 2 - spaceSize / 2,
            height: boxSize,
            child: _cover(index: 1))
      ],
    );
  }

  // 2张 上下
  Widget _cover3() {
    return Column(
      children: [
        SizedBox(
            width: boxSize,
            height: boxSize / 2 - spaceSize / 2,
            child: _cover(index: 0)),
        const SizedBox(
          height: spaceSize,
        ),
        SizedBox(
            width: boxSize,
            height: boxSize / 2 - spaceSize / 2,
            child: _cover(index: 1))
      ],
    );
  }

  // 三张 ： 左1右2
  Widget _cover4() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: boxSize / 2 - spaceSize / 2,
            height: boxSize,
            child: _cover(index: 0)),
        Column(
          children: [
            SizedBox(
                width: boxSize / 2 - spaceSize / 2,
                height: boxSize / 2 - spaceSize / 2,
                child: _cover(index: 1)),
            const SizedBox(
              height: spaceSize,
            ),
            SizedBox(
                width: boxSize / 2 - spaceSize / 2,
                height: boxSize / 2 - spaceSize / 2,
                child: _cover(index: 2))
          ],
        )
      ],
    );
  }

  // 三张：左2 右1
  Widget _cover5() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            SizedBox(
                width: boxSize / 2 - spaceSize / 2,
                height: boxSize / 2 - spaceSize / 2,
                child: _cover(index: 0)),
            const SizedBox(
              height: spaceSize,
            ),
            SizedBox(
                width: boxSize / 2 - spaceSize / 2,
                height: boxSize / 2 - spaceSize / 2,
                child: _cover(index: 1))
          ],
        ),
        SizedBox(
            width: boxSize / 2 - spaceSize / 2,
            height: boxSize,
            child: _cover(index: 2))
      ],
    );
  }

  // 三张：上1 下2
  Widget _cover6() {
    return Column(
      children: [
        SizedBox(
            width: boxSize,
            height: boxSize / 2 - spaceSize / 2,
            child: _cover(index: 0)),
        const SizedBox(
          height: spaceSize,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: boxSize / 2 - spaceSize / 2,
                height: boxSize / 2 - spaceSize / 2,
                child: _cover(index: 1)),
            SizedBox(
                width: boxSize / 2 - spaceSize / 2,
                height: boxSize / 2 - spaceSize / 2,
                child: _cover(index: 2))
          ],
        )
      ],
    );
  }

  // 三张：上2 下1
  Widget _cover7() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: boxSize / 2 - spaceSize / 2,
                height: boxSize / 2 - spaceSize / 2,
                child: _cover(index: 0)),
            SizedBox(
                width: boxSize / 2 - spaceSize / 2,
                height: boxSize / 2 - spaceSize / 2,
                child: _cover(index: 1))
          ],
        ),
        const SizedBox(
          height: spaceSize,
        ),
        SizedBox(
            width: boxSize,
            height: boxSize / 2 - spaceSize / 2,
            child: _cover(index: 2)),
      ],
    );
  }

  // 四张：上下各两张
  Widget _cover8() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: boxSize / 2 - spaceSize / 2,
                height: boxSize / 2 - spaceSize / 2,
                child: _cover(index: 0)),
            SizedBox(
                width: boxSize / 2 - spaceSize / 2,
                height: boxSize / 2 - spaceSize / 2,
                child: _cover(index: 1))
          ],
        ),
        const SizedBox(
          height: spaceSize,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: boxSize / 2 - spaceSize / 2,
                height: boxSize / 2 - spaceSize / 2,
                child: _cover(index: 2)),
            SizedBox(
                width: boxSize / 2 - spaceSize / 2,
                height: boxSize / 2 - spaceSize / 2,
                child: _cover(index: 3))
          ],
        ),
      ],
    );
  }

  Widget _cover({int index = 0}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: FadeInImage.assetNetwork(
          placeholder: 'assets/images/common/lazy-1.png',
          image: widget.articleItem.coverUrlList[index],
          fit: BoxFit.cover),
    );
  }

  Widget _bottom() {
    return Row(children: [
      Expanded(
        child: AvatarRoleName(
            type: widget.articleItem.user.type,
            coverPictureUrl: widget.articleItem.user.coverPictureUrl,
            nickname: widget.articleItem.user.nickname),
      ),
      Expanded(
        child: CommonLikeRead(
            commentCount: widget.articleItem.commentCount,
            thumbUpCount: widget.articleItem.thumbUpCount,
            readCount: widget.articleItem.readCount),
      )
    ]);
  }
}
