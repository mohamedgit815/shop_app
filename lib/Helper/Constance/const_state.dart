import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/Model/user_model.dart';
import 'package:shop_app/View/Main/localizations.dart';
import 'package:shop_app/ViewModel/Functions/auth_functions.dart';
import 'package:shop_app/ViewModel/State/lang_state.dart';
import 'package:shop_app/ViewModel/State/theme_state.dart';


/// Main Enum Applications
enum MainEnum{
  /// The Main Languages in The Application
  english , arabic , espanol ,

  /// Text Languages
  textProfile , textHome , textAccount , textLogOut , textChange , textUpdate ,
  textSetting , textSure , textYes , textNo , textChooseLang , textChat , textPost ,
  textWrite , textDelete , textPeople , textAccept , textRefused , textRequests ,
  textFriends , textMessage , textBlock , textName , textPw , textEmail , textPwHere,
  textYou ,

}

/// Extension
extension MainContext on BuildContext {
  AppLocalization? get translate => AppLocalization.of(this);
  ThemeData get theme => Theme.of(this);
  ModalRoute<Object?>? get modal => ModalRoute.of(this);
  bool get keyBoard => MediaQuery.of(this).viewInsets.bottom == 0;
  Size get mainSize => MediaQuery.of(this).size;
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
}

/// State
final themeProv = ChangeNotifierProvider((ref)=>ThemeState());
final langProv = ChangeNotifierProvider((ref)=>LangState());
final myDataProv = FutureProvider<UserModel>((ref)=>AuthFunctions.fetchProfileData());
// final fetchHomeProv = FutureProvider((ref)=>HomeFunctions.fetchHomeData());

class ConstUrl {
  static String mainUrl = 'http://localhost:3000';
}
