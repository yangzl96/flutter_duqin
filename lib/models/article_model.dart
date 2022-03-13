import 'package:duqin/models/recommend_interface.dart';
import 'package:duqin/models/user_model.dart';

class ArticleList {
  final List<ArticleItem> list;
  ArticleList(this.list);
  factory ArticleList.fromJson(List<dynamic> list) {
    return ArticleList(list.map((item) {
      return ArticleItem.fromJson(item);
    }).toList());
  }
}

class ArticleItem implements RecommendInterface {
  final int id;
  final int userId;
  final List<dynamic> coverUrlList;
  final String title;
  final int commentCount;
  final int thumbUpCount;
  final int readCount;
  final UserItem user;

  ArticleItem({
    required this.id,
    required this.userId,
    required this.coverUrlList,
    required this.title,
    required this.commentCount,
    required this.thumbUpCount,
    required this.readCount,
    required this.user,
  });

  factory ArticleItem.fromJson(dynamic item) {
    return ArticleItem(
      id: item['id'],
      userId: item['userId'],
      coverUrlList: item['coverUrlList'],
      title: item['title'],
      commentCount: item['commentCount'],
      thumbUpCount: item['thumbUpCount'],
      readCount: item['readCount'],
      user: UserItem.fromJson(item['user']),
    );
  }
}
