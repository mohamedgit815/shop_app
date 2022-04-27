import 'package:flutter/material.dart';
import 'package:shop_app/View/Auth/Login/mobile_login_page.dart';
import 'package:shop_app/View/Main/responsive_builder.dart';

class MainLoginScreen extends StatelessWidget {
  const MainLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveBuilderScreen(
        mobile: MobileLoginPage()
    );
  }
}
