import 'package:flutter/material.dart';
import 'package:shop_app/View/Main/responsive_builder.dart';
import 'package:shop_app/View/Views/HomeView/mobile_home_page.dart';

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveBuilderScreen(
        mobile: MobileHomePage()
    );
  }
}
