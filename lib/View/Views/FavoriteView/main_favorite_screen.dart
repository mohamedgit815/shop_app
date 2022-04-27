import 'package:flutter/material.dart';
import 'package:shop_app/View/Main/responsive_builder.dart';
import 'package:shop_app/View/Views/FavoriteView/mobile_favorite_page.dart';

class MainFavoriteScreen extends StatelessWidget {
  const MainFavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveBuilderScreen(
        mobile: MobileFavoritePage()
    );
  }
}
