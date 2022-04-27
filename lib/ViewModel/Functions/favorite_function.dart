import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/Helper/Constance/const_functions.dart';
import 'package:shop_app/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:shop_app/Model/favorite_model.dart';
import 'package:shop_app/ViewModel/State/switch_state.dart';


class FavoriteFunction {
  static final Dio _dio = ConstGeneral.dio;
  static const String _getUrl = '/favorite';

  // static Future<void> fetchFavorite({
  //   required String idUser , required BuildContext context
  // }) {
  //   try{
  //     final Stream<Response> _response = _dio.getUri(Uri.parse('$_getUrl/$idUser')).asStream();
  //     // final Map<String,dynamic> _map = _response.data;
  //     // final List<dynamic> _body = _map['data'];
  //
  //     if(_response.statusCode == 200){
  //      _body.map((e) => FavoriteModel.fromApp(e)).toList();
  //     }
  //
  //
  //   }on DioError catch(e){
  //
  //     if(e.response!.statusCode == 404) {
  //       customSnackBar(text: 'Error In Fetch 404', context: context);
  //     } else {
  //       customSnackBar(text: 'Error In Fetch 500', context: context);
  //     }
  //   }
  //
  // }


  static Stream<Response> fetchFavorite({required String idUser}){
         return _dio.getUri(Uri.parse('$_getUrl/$idUser')).asStream();
  }

  // static testFetchFavorite({required String idUser}){
  //   final List<dynamic> _data = [];
  //
  //    _dio.getUri(Uri.parse('$_getUrl/$idUser')).asStream().listen((event) {
  //     event.data
  //    final List<FavoriteModel> _model =  _data.map((e) => FavoriteModel.fromApp(e)).toList();
  //
  //    return _model;
  //   });
  // }

  static checkFavorite({
    required BuildContext context ,required WidgetRef widgetRef ,
    required ChangeNotifierProvider<SwitchState> provider ,required String idProduct
  }) async {
    try{

      //final Stream<Response> _response =
      _dio.postUri(Uri.parse('$_getUrl/$idProduct')).asStream().listen((event) {
        if(event.statusCode == 200) {
          print(event.data['message']);
        }
      });

      //print(_response);

      // if(_response.statusCode == 200) {
      //
      //    widgetRef.read(provider).funcSwitchEqual(_response.data['message']);
      //
      // }

    }  on DioError catch (e) {
      if(e.response!.statusCode == 404) {

         widgetRef.read(provider).funcSwitchEqual(e.response!.data['message']);

      } else {
        customSnackBar(text: 'Error In Fetch 500', context: context);
      }
    }
  }


  static Future<void> postFavorite({
    required String idProducts , required String idUser , required String image ,
    required String name, required BuildContext context
  }) async {
    try{
      final Response _response = await _dio.postUri(Uri.parse('$_getUrl/'),data: {
        'idProducts' : idProducts ,
        'idUser': idUser ,
        'image': image ,
        'name': name
      });

      if(_response.statusCode == 200) {
        customSnackBar(text: '$name Add to Favorite', context: context);
      }

    } on DioError catch (e) {
      if(e.response!.statusCode == 404) {
        customSnackBar(text: 'Error In Fetch 404', context: context);
      } else {
        customSnackBar(text: 'Error In Fetch 500', context: context);
      }
    }
  }


  static Future<void> deleteFavorite({
    required BuildContext context, required String idProduct, required String name
  }) async {
    try{
      final Response _response = await _dio.deleteUri(Uri.parse('$_getUrl/$idProduct'));

      if(_response.statusCode == 200) {
        customSnackBar(text: '$name Add to Removed', context: context);
      }

    } on DioError catch (e){
      if(e.response!.statusCode == 404) {
        customSnackBar(text: 'Error In Fetch 404', context: context);
      } else {
        customSnackBar(text: 'Error In Fetch 500', context: context);
      }
    }
    }

}