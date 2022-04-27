import 'package:flutter/material.dart';
import 'package:shop_app/Model/user_model.dart';
import 'package:shop_app/View/Main/responsive_builder.dart';
import 'package:shop_app/View/Profile/MainUpdateImage/mobile_update_image_page.dart';


class MainUpdateImageScreen extends StatelessWidget {
  final UserModel userModel ;

  const MainUpdateImageScreen({Key? key,required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ResponsiveBuilderScreen(
        mobile: MobileUpdateImagePage(userModel: userModel,)
    );
  }
}
