import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Model/home_model.dart';
import 'package:shop_app/Model/user_model.dart';
import 'package:shop_app/View/Auth/Login/main_login_screen.dart';
import 'package:shop_app/View/Auth/Register/main_register_screen.dart';
import 'package:shop_app/View/Profile/MainUpdateImage/main_update_image_screen.dart';
import 'package:shop_app/View/Profile/MainUpdatePw/main_update_pw_screen.dart';
import 'package:shop_app/View/Profile/main_profileme_screen.dart';
import 'package:shop_app/View/Views/HomeView/DetailsView/main_details_screen.dart';


class RouteGenerators {
   static const String routeTest = '/Test';


   static const String login = '/MainLoginScreen';
   static const String register = '/MainRegisterScreen';
   static const String profileMe = '/MainProfileMeScreen';
   static const String updatePW = '/MainUpdatePwScreen';
   static const String updateImage = '/MainUpdateImageScreen';
   static const String homeDetails = '/MainHomeDetailsScreen';

   static MaterialPageRoute<dynamic> _materialPageRoute(Widget page){
     return MaterialPageRoute(builder: (_)=>page);
   }

   static CupertinoPageRoute<dynamic> _cupertinoPageRoute(Widget page){
     return CupertinoPageRoute(builder: (_)=>page);
   }


   static Route<dynamic>? onGenerate(RouteSettings settings) {
    switch(settings.name) {

      case login : return _materialPageRoute(const MainLoginScreen());


      case register : return _cupertinoPageRoute(const MainRegisterScreen());


      case profileMe : return _materialPageRoute(const MainProfileMeScreen());



      case updateImage :
        final UserModel _userModel = settings.arguments as UserModel;
        return _cupertinoPageRoute(MainUpdateImageScreen(userModel: _userModel,));



      case updatePW :
        final UserModel _userModel = settings.arguments as UserModel;
        return _cupertinoPageRoute(MainUpdatePwScreen(userModel: _userModel,));


      case homeDetails :
        final HomeModel _homeModel = settings.arguments as HomeModel;
        return _cupertinoPageRoute(MainDetailsScreen(homeModel: _homeModel,));

    }
    return null;
  }
}