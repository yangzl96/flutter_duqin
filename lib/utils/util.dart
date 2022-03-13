import 'dart:math';

import 'package:flutter/material.dart';

double toRpx(BuildContext context, double size) {
  double rpx = MediaQuery.of(context).size.width / 750;
  return size * rpx;
}

formatCharCount(int count) {
  if (count == null || count < 0 || count.isNaN) {
    return '0';
  }
  String strCount = count.toString();
  if (strCount.length >= 5) {
    // 38128 => 3.8w
    // 381288 => 38.1w
    String prefix = strCount.substring(0, strCount.length - 4);
    if (strCount.length == 5) {
      prefix += '.${strCount[1]}';
    }
    if (strCount.length == 6) {
      prefix += '.${strCount[2]}';
    }
    return prefix + 'w';
  }
  return strCount;
}

// 随机获取指定返回内的值
// from 【包含min】 to  [包含max]
int getRandomRangeInt(int min, int max) {
  final Random random = Random();
  return min + random.nextInt(max + 1 - min);
}

/// 个数补零
String formatNumber(int count) {
  String strCount = count.toString();
  return strCount.length > 1 ? strCount : '0$strCount';
}

// 秒数 => 时分秒
String secondsToTime(int seconds) {
  if (seconds == null || seconds <= 0 || seconds.isNaN) {
    return '00:00';
  }
  // 时分数
  int hours = 0;
  // 分钟数
  int minutes = 0;
  // 除整数分钟外剩余的秒数
  int remainingSeconds = 0;

  hours = (seconds / 60 / 60).floor();
  minutes = (seconds / 60 % 60).floor();
  remainingSeconds = seconds % 60;

  // 返回 时:分:秒
  return '${formatNumber(hours)}:${formatNumber(minutes)}:${formatNumber(remainingSeconds)}';
}
