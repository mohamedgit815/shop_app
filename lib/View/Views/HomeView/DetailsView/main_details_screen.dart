import 'package:flutter/material.dart';
import 'package:shop_app/Model/home_model.dart';
import 'package:shop_app/View/Main/responsive_builder.dart';
import 'package:shop_app/View/Views/HomeView/DetailsView/mobile_details_page.dart';

class MainDetailsScreen extends StatelessWidget {
  final HomeModel homeModel;
  const MainDetailsScreen({Key? key,required this.homeModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilderScreen(
        mobile: MobileDetailsPage(homeModel: homeModel)
    );
  }
}
