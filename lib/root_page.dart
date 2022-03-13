import 'package:duqin/config/app_colors.dart';
import 'package:duqin/pages/home_page.dart';
import 'package:duqin/pages/music_page.dart';
import 'package:duqin/pages/profile_page.dart';
import 'package:duqin/pages/tiny_video_page.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  RootPage({Key? key}) : super(key: key);
  @override
  State<RootPage> createState() => _RootPageState();
}

final Map<String, String> _bottomNames = {
  'home': '首页',
  'music': '音乐',
  'create_media': '',
  'tiny_video': '小视频',
  'profile': '我的'
};

class _RootPageState extends State<RootPage> {
  // 索引
  int _currentIndex = 0;
  // 页面
  final List<Widget> _pages = [
    HomePage(),
    MusicPage(),
    Container(),
    TinyVideoPage(),
    ProfilePage()
  ];
  // 底部导航栏
  final List<BottomNavigationBarItem> _bottomNavBarList = [];
  void initState() {
    super.initState();
    // 初始化底部导航栏
    _bottomNames.forEach((key, value) {
      _bottomNavBarList.add(_bottomNavBarItem(key, value));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavBarList,
        currentIndex: _currentIndex,
        onTap: _onTapClick,
        type: BottomNavigationBarType.fixed,
      ),
      floatingActionButton: _createMediaButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // 中间凸起按钮
  _createMediaButton() {
    return Container(
      width: 44,
      height: 44,
      margin: const EdgeInsets.only(top: 56),
      child: FloatingActionButton(
        backgroundColor: AppColors.nav,
        child: Image.asset(
          'assets/images/icons/create_media.png',
        ),
        onPressed: _onCreateMedia,
      ),
    );
  }

  // 中间按钮点击
  _onCreateMedia() {
    print('1111');
  }

  // 切换菜单
  _onTapClick(int value) {
    // 处理中间按钮的点击情况，拦截这个点击事件的处理，同时避免点击周围出现切换图片的问题
    if (value == 2) {
      return _onCreateMedia();
    }
    setState(() {
      _currentIndex = value;
    });
  }

  // 生成底部导航项
  BottomNavigationBarItem _bottomNavBarItem(String key, String value) {
    return BottomNavigationBarItem(
      label: value,
      tooltip: '', //长按不显示
      icon: Image.asset(
        'assets/images/icons/$key.png',
        width: 24,
        height: 24,
      ),
      activeIcon: Image.asset(
        'assets/images/icons/${key}_active.png',
        width: 24,
        height: 24,
      ),
    );
  }
}
