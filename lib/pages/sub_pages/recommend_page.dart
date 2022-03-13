// ignore_for_file: prefer_const_constructors

import 'package:duqin/models/article_model.dart';
import 'package:duqin/models/recommend_interface.dart';
import 'package:duqin/models/song_model.dart';
import 'package:duqin/models/video_model.dart';
import 'package:duqin/services/recommend_services.dart';
import 'package:duqin/widgets/article_card.dart';
import 'package:duqin/widgets/song_card.dart';
import 'package:duqin/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class RecommendPage extends StatefulWidget {
  RecommendPage({Key? key}) : super(key: key);

  @override
  State<RecommendPage> createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage>
    with AutomaticKeepAliveClientMixin {
  late EasyRefreshController _easyRefreshController;
  List<dynamic> _recommendList = [];
  int page = 1;
  int limit = 10;
  bool hasMore = true;
  bool error = false;
  String errorMsg = '';

  @override
  void initState() {
    super.initState();
    _easyRefreshController = EasyRefreshController();
    _getRecommend();
  }

  // push 累加
  Future _getRecommend({bool push = false}) async {
    try {
      List<dynamic> result = await RecommendService.getRecommends(page: page);
      List<RecommendInterface?> recommendList = result.map((item) {
        if (item != null && item['songEntity'] != null) {
          return SongItem.fromJson(item['songEntity']);
        } else if (item != null && item['articleEntity'] != null) {
          return ArticleItem.fromJson(item['articleEntity']);
        } else if (item != null && item['videoEntity'] != null) {
          return VideoItem.fromJson(item['videoEntity']);
        }
      }).toList();

      recommendList = recommendList.where((item) => item != null).toList();
      print(recommendList);

      // return
      // 将数据转化为实体类
      setState(() {
        page++;
        if (push) {
          _recommendList.addAll(recommendList);
        } else {
          _recommendList = recommendList;
        }
      });
    } catch (e) {
      setState(() {
        error = true;
        errorMsg = e.toString();
        print(errorMsg);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      header: ClassicalHeader(),
      footer: ClassicalFooter(),
      controller: _easyRefreshController,
      onRefresh: _onRefresh,
      enableControlFinishLoad: true,
      enableControlFinishRefresh: true,
      onLoad: _onLoad,
      child: ListView.builder(
          itemCount: _recommendList.length,
          itemBuilder: (BuildContext context, int index) {
            RecommendInterface widgetItem = _recommendList[index];
            return getWidgetByInterface(widgetItem);
          }),
    );
  }

  Widget getWidgetByInterface(RecommendInterface widgetItem) {
    if (widgetItem is SongItem) {
      return _columnBox(SongCard(songItem: widgetItem));
    } else if (widgetItem is ArticleItem) {
      return _columnBox(ArticleCard(articleItem: widgetItem));
    } else if (widgetItem is VideoItem) {
      return _columnBox(VideoCard(videoItem: widgetItem));
    } else {
      return SizedBox.shrink(); //空的组件
    }
  }

  Widget _columnBox(Widget card) {
    return Column(
      children: [const SizedBox(height: 8), card],
    );
  }

  // 下拉刷新
  Future<void> _onRefresh() async {
    page = 1;
    await _getRecommend();
    // 手动刷新完成
    _easyRefreshController.finishRefresh();
    // 重置一下否则下拉刷新后 上拉加载的Loading就没有了
    _easyRefreshController.resetLoadState();
  }

  // 上拉加载
  Future<void> _onLoad() async {
    await _getRecommend(push: true);
    // 加载完毕
    // 如果 hasMore 为 true 表示 还有更多
    // 那么 noMore 是否没有更多了 就是 false 所以取反
    _easyRefreshController.finishLoad(noMore: !hasMore);
  }

  @override
  bool get wantKeepAlive => true;
}
