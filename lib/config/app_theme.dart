import 'package:duqin/config/app_colors.dart';
import 'package:flutter/material.dart';

final ThemeData themeData = ThemeData(
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.page,
  indicatorColor: AppColors.active, // 选项卡栏中所选选项卡指示器的颜色。
  // 文字颜色
  textTheme: const TextTheme(
    bodyText2: TextStyle(
      color: AppColors.unactive,
    ),
  ),
  // appBar主题色
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.nav,
    elevation: 0,
  ),
  // tabbar的样式
  tabBarTheme: const TabBarTheme(
    unselectedLabelColor: AppColors.unactive,
    indicatorSize: TabBarIndicatorSize.label,
    labelStyle: TextStyle(
      fontSize: 18,
    ),
    labelPadding: EdgeInsets.symmetric(horizontal: 12),
  ),
  // 点击底部菜单的水波纹
  splashColor: Colors.transparent, // 取消水波纹效果
  highlightColor: Colors.transparent, // 取消水波纹效果
  // 底部按钮
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.nav,
    selectedItemColor: AppColors.active,
    unselectedItemColor: AppColors.unactive,
    selectedLabelStyle: TextStyle(
      fontSize: 12,
    ),
  ),
);
