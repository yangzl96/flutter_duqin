import 'package:duqin/pages/sub_pages/singer_page.dart';
import 'package:duqin/pages/sub_pages/song_page.dart';
import 'package:duqin/widgets/root_page_head.dart';
import 'package:flutter/material.dart';

class MusicPage extends StatefulWidget {
  MusicPage({Key? key}) : super(key: key);

  @override
  State<MusicPage> createState() => _MusicPageState();
}

const List<Tab> _tabs = [
  Tab(text: '歌曲'),
  Tab(text: '歌手'),
];

final List<Widget> _tabContent = [
  SongPage(),
  SingerPage(),
];

class _MusicPageState extends State<MusicPage> with TickerProviderStateMixin {
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
}
