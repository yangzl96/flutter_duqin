import 'dart:async';

import 'package:duqin/root_page.dart';
import 'package:flutter/material.dart';

class TransitPage extends StatefulWidget {
  TransitPage({Key? key}) : super(key: key);

  @override
  State<TransitPage> createState() => _TransitPageState();
}

class _TransitPageState extends State<TransitPage> {
  late Timer _timer;
  int currentTime = 5;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        currentTime--;
      });
      if (currentTime <= 0) {
        jumpRootPage();
      }
    });
  }

  jumpRootPage() {
    _timer.cancel();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return RootPage();
    }), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/common/page.png',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Positioned(
              // 状态栏的高度 + 10
              top: MediaQuery.of(context).padding.top + 10,
              right: 10,
              child: InkWell(
                child: _clipButton(),
                onTap: jumpRootPage,
              ))
        ],
      ),
    );
  }

  _clipButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 50,
        height: 50,
        color: Colors.black.withOpacity(0.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '跳过',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            Text(
              '${currentTime}s',
              style: TextStyle(color: Colors.white, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
