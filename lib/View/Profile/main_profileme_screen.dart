import 'package:flutter/material.dart';
import 'package:shop_app/View/Main/responsive_builder.dart';
import 'package:shop_app/View/Profile/mobile_profileme_page.dart';


class MainProfileMeScreen extends StatelessWidget {
  static const String profileMe = '/MainProfileMeScreen';
  const MainProfileMeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return const ResponsiveBuilderScreen(
        mobile: MobileProfileMePage()
    );
  }
}
