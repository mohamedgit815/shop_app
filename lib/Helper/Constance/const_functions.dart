import 'dart:core';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/Helper/Constance/const_regexp.dart';
import 'package:shop_app/Helper/Widgets/Customs/custom_widgets.dart';


class ConstGeneral {

  static String mainUrl = 'http://192.168.1.7:3000';

  static final Dio dio = Dio(BaseOptions(
      baseUrl: mainUrl ,
      receiveDataWhenStatusError: true
  ));

  static Locale switchLang(String lang){
    SharedPreferences.getInstance().then((value) async {
      await value.setString('lang', lang);
    });
    if(lang == 'english'){
      lang = 'en';
    } else if(lang == 'arabic'){
      lang = 'ar';
    } else if(lang == 'espanol') {
      lang = 'es';
    }
    return Locale(lang,'');
  }

  static Center errorProvider(Object err){
    return Center(child: FittedBox(
        fit: BoxFit.scaleDown,
        child: CustomText(text: err.toString())),);
  }

  static Center loadingProvider(){
    return const Center(child: CircularProgressIndicator.adaptive(),);
  }

  static Visibility loadingVisibilityProvider(){
    return const Visibility(
        visible: false,
        child: CircularProgressIndicator.adaptive());
  }

  static Center notFoundData(String text){
    return Center(child: FittedBox(
      fit: BoxFit.scaleDown,
      child: CustomText(
        text: text ,
        fontSize: 20.0,
        color: ConstColor.lightMainColor,
      ),
    ),);
  }

  static MaterialStateProperty<Color> materialStateColor(Color color){
    return MaterialStateProperty.all<Color>(color);
  }
}

class ConstUser {
  static String? userId = '';
  static String? userFirst = '';
  static String? userLast = '';
  static String? userName = '';
  static String? userImage = '';
  static String? userEmail = '';
}

class ConstNavigator {

  static Future<dynamic> backPageRouter(BuildContext context) async {
    return await Navigator.of(context).maybePop();
  }

  static Future<dynamic> pushNamedRouter({required String route ,required BuildContext context}) async {
    return await Navigator.of(context).pushNamed(route,);
  }

  static Future<dynamic> pushNamedAndReplaceRouter({required String route ,required BuildContext context}) async {
    return await Navigator.of(context).pushReplacementNamed(route);
  }

  static Future<dynamic> pushNamedAndRemoveRouter({required String route ,required BuildContext context}) async {
    return await Navigator.of(context).pushNamedAndRemoveUntil(route , (route) => false);
  }

}

class ConstValidator {
  static String? validatorName(String? v) {
    return !v!.contains(regExpName) ? 'Enter your Name by write form' : null ;
  }

  static String? validatorEmail(String? v) {
    return !v!.contains(regExpEmail) ? 'Enter your Email by write form' : null ;
  }

  static String? validatorPhone(String? v) {
    return !v!.contains(regExpPhone) ? 'Enter your Phone by write form' : null;
  }

  static String? validatorPw(String? v) {
    return !v!.contains(regExpPw) ? '[UpperCase , LowerCase , \$ ,# ,%]' : null;
  }
}

class ConstColor {

// Dark Theme
  static const Color darkMainColor = Colors.indigo;
  static const Color darkColorOne = Color(0xff424242);
  static const Color darkColorTow = Color(0xff303030);
  static const Color darkColorFour = Color(0xff1a1a1a);



// LightTheme
//const Color lightMainColor = Color(0xFF333333);
  static const Color lightMainColor = Color(0xff075E55);
  static const Color lightColorTow = Color(0xffCC7D00);
  static const Color lightColorThree = Color(0xff7B7B7B);
  static const MaterialColor lightColorFour = Colors.red;


// HelperColors
  static const Color normalWhite = Color(0xffFFFFFF);
  static const Color normalTrans = Colors.transparent;
  static const MaterialColor normalGrey = Colors.grey;
  static const Color normalBlack = Color(0xff333333);
  static const Color helperColorOne = Color(0xffCCCCCC);
}