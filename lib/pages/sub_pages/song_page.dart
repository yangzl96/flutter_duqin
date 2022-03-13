// ignore_for_file: prefer_const_constructors

import 'package:duqin/models/song_model.dart';
import 'package:duqin/services/song_services.dart';
import 'package:duqin/widgets/song_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class SongPage extends StatefulWidget {
  SongPage({Key? key}) : super(key: key);

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage>
    with AutomaticKeepAliveClientMixin {
  late EasyRefreshController _easyRefreshController;
  List<SongItem> _songList = SongList([]).list;
  int page = 1;
  int limit = 10;
  bool hasMore = true;
  bool error = false;
  String errorMsg = '';

  @override
  void initState() {
    super.initState();
    _easyRefreshController = EasyRefreshController();
    _getSongs();
  }

  // push 累加
  Future _getSongs({bool push = false}) async {
    try {
      Map<String, dynamic> result = await SongService.getSongs(page: page);
      // 将数据转化为实体类
      SongList songListModel = SongList.fromJson(result['data']);
      setState(() {
        hasMore = page * limit < result['total'];
        page++;
        if (push) {
          _songList.addAll(songListModel.list);
        } else {
          _songList = songListModel.list;
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
          itemCount: _songList.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                SizedBox(height: 8),
                SongCard(songItem: _songList[index])
              ],
            );
          }),
    );
  }

  // 下拉刷新
  Future<void> _onRefresh() async {
    page = 1;
    await _getSongs();
    // 手动刷新完成
    _easyRefreshController.finishRefresh();
    // 重置一下否则下拉刷新后 上拉加载的Loading就没有了
    _easyRefreshController.resetLoadState();
  }

  // 上拉加载
  Future<void> _onLoad() async {
    if (hasMore) {
      await _getSongs(push: true);
    }
    // 加载完毕
    // 如果 hasMore 为 true 表示 还有更多
    // 那么 noMore 是否没有更多了 就是 false 所以取反
    _easyRefreshController.finishLoad(noMore: !hasMore);
  }

  @override
  bool get wantKeepAlive => true;
}
