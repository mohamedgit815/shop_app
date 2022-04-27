import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:shop_app/Model/user_model.dart';
import 'package:shop_app/View/Main/route_builder.dart';
import 'package:shop_app/ViewModel/State/switch_state.dart';


class AuthFunctions {
  static String mainUrl = 'http://192.168.1.7:3000';

  static final Dio _dio = Dio(BaseOptions(
      baseUrl: mainUrl ,
      receiveDataWhenStatusError: true
  ));

  static Future<void> loginAuth({
    required String email ,required String password , required WidgetRef widgetRef ,
    required GlobalKey<FormState> globalKey , required BuildContext context ,
    required ChangeNotifierProvider<SwitchState> indicatorState ,
  }) async
  {
    try {
      if(globalKey.currentState!.validate()){

        widgetRef.read(indicatorState).trueSwitch();

        final Response _response = await _dio.postUri(
            Uri.parse('/auth/login'), data: {
          'email': email ,
          'password': password
        });

        final Map<String,dynamic> _body = _response.data;
        final SharedPreferences _preferences = await SharedPreferences.getInstance();


        if (_response.statusCode == 200 || _response.statusCode == 201) {

          await _preferences.setString('id', _body['data']['id']);
          await _preferences.setString('first', _body['data']['first']);
          await _preferences.setString('last', _body['data']['last']);
          await _preferences.setString('email', _body['data']['email']);
          await _preferences.setString('image', _body['data']['image']);
          await _preferences.setString('token', _body['token']);


          widgetRef.read(indicatorState).falseSwitch();

          Navigator.pushNamedAndRemoveUntil(context, RouteGenerators.profileMe, (route) => false);
        }

      }
    } on DioError catch (e) {

      if(e.response!.statusCode == 404){
        widgetRef.read(indicatorState).falseSwitch();
        customSnackBar(text: e.response!.data['message'].toString(), context: context);
      } else {
        widgetRef.read(indicatorState).falseSwitch();

        customSnackBar(text: 'check your Internet' , context: context);
      }

    }
  }


    static Future<void> registerAuth({
    required String first , required String last ,required String email ,
    required GlobalKey<FormState> globalKey , required String password ,
    required BuildContext context , required WidgetRef widgetRef ,
    required ChangeNotifierProvider<SwitchState> indicatorState ,
}) async {
    try {
      if(globalKey.currentState!.validate()){

        widgetRef.read(indicatorState).trueSwitch();

        final Response _response = await _dio.postUri(
            Uri.parse('$mainUrl/auth/register'), data: {
          'first': first,
          'last': last,
          'email': email,
          'password': password
        });

        //final Map<String,dynamic> _body = _response.data;

        if (_response.statusCode == 200 || _response.statusCode == 201) {
          widgetRef.read(indicatorState).falseSwitch();
          Navigator.pushNamedAndRemoveUntil(context, RouteGenerators.login, (route) => false);
        }


      }
    } on DioError catch (e) {

      widgetRef.read(indicatorState).falseSwitch();
      if(e.response!.statusCode == 404) {
        customSnackBar(text: e.response!.data['message'].toString(), context: context);
      } else {

        customSnackBar(text: 'check your Internet' , context: context);

      }

    }
  }



  static Future<bool> checkPasswordUser({
    required String email, required String oldPassword ,
    required BuildContext context , required WidgetRef widgetRef,
    required ChangeNotifierProvider<SwitchState> provider ,
  }) async {
        final http.Response _response = await http.post(
            Uri.parse('$mainUrl/auth/checkPw/$email'),
            body: {
              'password': oldPassword
            });

        if(_response.statusCode == 200){
          return widgetRef.read(provider).funcSwitchEqual(true);

        } else {
         return  widgetRef.read(provider).funcSwitchEqual(false);

        }

  }



  static Future<void> updateName({
    required String first , required String last ,
    required String id , required BuildContext context ,
  }) async {
    try {

      final Response _response = await _dio.putUri(
          Uri.parse('/auth/updateName/$id'), data: {
        'first': first ,
        'last': last ,
      });

      final Map<String,dynamic> _body = _response.data;
      final SharedPreferences _preferences = await SharedPreferences.getInstance();

      if (_response.statusCode == 200 ) {
        await _preferences.setString('first', first);
        await _preferences.setString('last', last);
        await _preferences.reload();

        customSnackBar(text: _body['message'].toString(), context: context);
      }

    }on DioError catch (e) {

      if(e.response!.statusCode == 404){
        customSnackBar(text: 'You Must Enter Your Name' , context: context);
      } else {
        customSnackBar(text: 'check your Internet' , context: context);

      }

    }
  }


  static Future<void> updateImage({
    File? file , required String id , required BuildContext context ,
  }) async {
    try {

      final FormData _formData = FormData.fromMap({
        'profile': MultipartFile.fromFileSync(file!.path) ,
      });


      final Response _response = await _dio.putUri(Uri.parse('/auth/updateImage/$id'),data: _formData);
      final SharedPreferences _preferences = await SharedPreferences.getInstance();


      if(_response.statusCode == 200){

        _preferences.setString('image', '$mainUrl/${_response.data['profile_url']}');


        customSnackBar(text: 'Image Uploaded' , context: context);

      }

    } on DioError catch (e) {

      if(e.response!.statusCode == 404) {

        customSnackBar(text: 'Image Not Uploaded' , context: context);

      } else {
        customSnackBar(text: 'check your Internet' , context: context);
      }

    }
  }


  static Future<void> updatePassword({
    required String newPassword , required String id ,
    required BuildContext context , required GlobalKey<FormState> globalKey
  }) async {
    try {

      if(globalKey.currentState!.validate()){
        final Response _response = await _dio.putUri(
            Uri.parse('/auth/updatePw/$id'), data: {
          'password': newPassword
        });

        final Map<String,dynamic> _body = _response.data;

        if (_response.statusCode == 200 ) {

          customSnackBar(text: _body['message'].toString(), context: context);

          Navigator.maybePop(context);

        }

      }

    } on DioError catch (e) {

      if(e.response!.statusCode == 404){

        customSnackBar(text: 'Enter your New Password' , context: context);

      } else {
        customSnackBar(text: 'check your Internet' , context: context);

      }

    }
  }


  /// Fetch localData
  static Future<UserModel> fetchProfileData() async {

    final SharedPreferences _preferences = await SharedPreferences.getInstance();

    final Map<String , dynamic> _data = {
      'id': _preferences.getString('id') ,
      'first': _preferences.getString('first') ,
      'last': _preferences.getString('last') ,
      'image': _preferences.getString('image') ,
      'email': _preferences.getString('email') ,
      'name': '${_preferences.getString('first')} ${_preferences.getString('last')}'
    };

    final UserModel _userModel = UserModel.fromApp(_data);

    return _userModel;

  }


  static Future<void> signOut() async {
    final SharedPreferences _preferences = await SharedPreferences.getInstance();
    await _preferences.clear();
    await SystemNavigator.pop();
  }
}