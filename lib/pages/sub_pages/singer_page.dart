// ignore_for_file: prefer_const_constructors

import 'package:duqin/models/user_model.dart';
import 'package:duqin/services/user_services.dart';
import 'package:duqin/widgets/singer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class SingerPage extends StatefulWidget {
  SingerPage({Key? key}) : super(key: key);

  @override
  State<SingerPage> createState() => _SingerPageState();
}

class _SingerPageState extends State<SingerPage>
    with AutomaticKeepAliveClientMixin {
  late EasyRefreshController _easyRefreshController;

  List<UserItem> _singerList = UserList([]).list;
  int page = 1;
  int limit = 10;
  bool hasMore = true;
  bool error = false;
  String errorMsg = '';

  @override
  void initState() {
    super.initState();
    _easyRefreshController = EasyRefreshController();
    _getUsers();
  }

  Future _getUsers({bool push = false}) async {
    try {
      Map<String, dynamic> result =
          await UserService.getUsers(page: page, type: '');
      // 将数据转化为实体类
      UserList userListModel = UserList.fromJson(result['data']);
      setState(() {
        hasMore = page * limit < result['total'];
        page++;
        if (push) {
          _singerList.addAll(userListModel.list);
        } else {
          _singerList = userListModel.list;
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
      child: _buildBody(),
    );
  }

  // 下拉刷新
  Future<void> _onRefresh() async {
    page = 1;
    await _getUsers();
    // 手动刷新完成
    _easyRefreshController.finishRefresh();
    // 重置一下否则下拉刷新后 上拉加载的Loading就没有了
    _easyRefreshController.resetLoadState();
  }

  // 上拉加载
  Future<void> _onLoad() async {
    if (hasMore) {
      await _getUsers(push: true);
    }
    // 加载完毕
    // 如果 hasMore 为 true 表示 还有更多
    // 那么 noMore 是否没有更多了 就是 false 所以取反
    _easyRefreshController.finishLoad(noMore: !hasMore);
  }

  _buildBody() {
    return GridView.builder(
        padding: EdgeInsets.only(top: 8),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
            mainAxisExtent: (MediaQuery.of(context).size.width / 2) * 1.3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 1),
        itemCount: _singerList.length,
        itemBuilder: (BuildContext context, int index) {
          bool isEven = index.isEven;
          double pl = isEven ? 18 : 9;
          double pr = isEven ? 9 : 18;
          return Container(
            padding: EdgeInsets.only(top: 18, left: pl, right: pr),
            color: Colors.white,
            child: SingerCard(
              userItem: _singerList[index],
            ),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
