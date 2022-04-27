import 'package:flutter/material.dart';
import 'package:shop_app/View/Auth/Register/mobile_register_page.dart';
import 'package:shop_app/View/Main/responsive_builder.dart';

class MainRegisterScreen extends StatelessWidget {
  const MainRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveBuilderScreen(
        mobile: MobileRegisterPage()
    );
  }
}
