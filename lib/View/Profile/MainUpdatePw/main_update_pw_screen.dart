import 'package:flutter/material.dart';
import 'package:shop_app/Model/user_model.dart';
import 'package:shop_app/View/Main/responsive_builder.dart';
import 'package:shop_app/View/Profile/MainUpdatePw/mobile_update_page.dart';


class MainUpdatePwScreen extends StatelessWidget {
  final UserModel userModel;

  static const String profileMe = '/MainProfileMeScreen';
  const MainUpdatePwScreen({Key? key,required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return ResponsiveBuilderScreen(
        mobile: MobileUpdatePage(userModel: userModel,)
    );
  }
}
