// ignore_for_file: prefer_const_constructors

import 'package:duqin/models/video_model.dart';
import 'package:duqin/services/video_services.dart';
import 'package:duqin/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class VideoPage extends StatefulWidget {
  VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage>
    with AutomaticKeepAliveClientMixin {
  late EasyRefreshController _easyRefreshController;
  List<VideoItem> _videoList = VideoList([]).list;
  int page = 1;
  int limit = 10;
  bool hasMore = true;
  bool error = false;
  String errorMsg = '';

  @override
  void initState() {
    super.initState();
    _easyRefreshController = EasyRefreshController();
    _getVideos();
  }

  // push 累加
  Future _getVideos({bool push = false}) async {
    try {
      Map<String, dynamic> result = await VideoService.getVideos(page: page);
      // 将数据转化为实体类
      VideoList videoListModel = VideoList.fromJson(result['data']);
      setState(() {
        hasMore = page * limit < result['total'];
        page++;
        if (push) {
          _videoList.addAll(videoListModel.list);
        } else {
          _videoList = videoListModel.list;
        }
      });
    } catch (e) {
      setState(() {
        error = true;
        errorMsg = e.toString();
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
          itemCount: _videoList.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                SizedBox(height: 8),
                VideoCard(videoItem: _videoList[index])
              ],
            );
          }),
    );
  }

  // 下拉刷新
  Future<void> _onRefresh() async {
    page = 1;
    await _getVideos();
    // 手动刷新完成
    _easyRefreshController.finishRefresh();
    // 重置一下否则下拉刷新后 上拉加载的Loading就没有了
    _easyRefreshController.resetLoadState();
  }

  // 上拉加载
  Future<void> _onLoad() async {
    if (hasMore) {
      await _getVideos(push: true);
    }
    // 加载完毕
    // 如果 hasMore 为 true 表示 还有更多
    // 那么 noMore 是否没有更多了 就是 false 所以取反
    _easyRefreshController.finishLoad(noMore: !hasMore);
  }

  @override
  bool get wantKeepAlive => true;
}
