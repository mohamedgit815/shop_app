import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/Helper/Constance/const_functions.dart';
import 'package:shop_app/View/Auth/Login/main_login_screen.dart';
import 'package:shop_app/View/Main/app.dart';
import 'package:shop_app/View/Profile/main_profileme_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences _preferences = await SharedPreferences.getInstance();
  //_preferences.clear();

  Widget _screen;
  String? _token = _preferences.getString('id');




  if(_token == null || _token.isEmpty) {

    _screen = const MainLoginScreen();

    ConstUser.userId = _token;
    ConstUser.userFirst = _preferences.getString('first');
    ConstUser.userLast = _preferences.getString('last');
    ConstUser.userName = '${_preferences.getString('first')} ${_preferences.getString('last')}';
    ConstUser.userEmail = _preferences.getString('email');
    ConstUser.userImage = _preferences.getString('image');


  } else {
    _screen = const MainProfileMeScreen();
  }



  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(ProviderScope(child: MyApp(screen: _screen)));
}

