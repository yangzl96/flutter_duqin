import 'dart:collection';

import 'package:duqin/models/recommend_interface.dart';
import 'package:duqin/models/user_model.dart';

class VideoList {
  final List<VideoItem> list;
  VideoList(this.list);
  // 将 VideoList中的每一项都遍历转换成 VideoItem类型的Map输出
  factory VideoList.fromJson(List<dynamic> list) {
    return VideoList(list.map((item) => VideoItem.fromJson(item)).toList());
  }
}

class VideoItem implements RecommendInterface {
  final int id;
  final int userId;
  final UserItem user;
  final String coverPictureUrl;
  final String videoUrl;
  final String title;
  final String intro;
  final int commentCount;
  final int thumbUpCount;
  final int readCount;
  final int shareCount;
  final int contentSeconds;

  VideoItem(
      {required this.id,
      required this.userId,
      required this.user,
      required this.coverPictureUrl,
      required this.videoUrl,
      required this.title,
      required this.intro,
      required this.commentCount,
      required this.thumbUpCount,
      required this.readCount,
      required this.shareCount,
      required this.contentSeconds});

  factory VideoItem.fromJson(dynamic item) {
    return VideoItem(
        id: item['id'],
        userId: item['userId'],
        user: UserItem.fromJson(item['user']),
        coverPictureUrl: item['coverPictureUrl'],
        videoUrl: item['videoUrl'],
        title: item['title'],
        intro: item['intro'],
        commentCount: item['commentCount'],
        thumbUpCount: item['thumbUpCount'],
        readCount: item['readCount'],
        shareCount: item['shareCount'],
        contentSeconds: item['contentSeconds']);
  }
}
