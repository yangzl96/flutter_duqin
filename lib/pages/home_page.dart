import 'package:duqin/http/http.dart';
import 'package:duqin/pages/sub_pages/article_page.dart';
import 'package:duqin/pages/sub_pages/recommend_page.dart';
import 'package:duqin/pages/sub_pages/singer_page.dart';
import 'package:duqin/pages/sub_pages/song_page.dart';
import 'package:duqin/pages/sub_pages/tiny_video_page.dart';
import 'package:duqin/pages/sub_pages/video_page.dart';
import 'package:duqin/widgets/root_page_head.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

const List<Tab> _tabs = [
  Tab(text: '歌曲'),
  Tab(text: '推荐'),
  Tab(text: '歌手'),
  Tab(text: '小视频'),
  Tab(text: '文章'),
  Tab(text: '视频'),
];

final List<Widget> _tabContent = [
  SongPage(),
  RecommendPage(),
  SingerPage(),
  TinyVideoPage(),
  ArticlePage(),
  VideoPage(),
];

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: _tabs.length, initialIndex: 1, vsync: this);
    // 监听切换
    _tabController.addListener(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
    _getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: RootPageHead(),
          bottom: TabBar(
              tabs: _tabs, controller: _tabController, isScrollable: true)),
      body: TabBarView(
        controller: _tabController,
        children: _tabContent,
      ),
    );
  }

  void _getList() async {
    final result = await Http.get('/v1/song/info/2');
    print(result);
  }
}
