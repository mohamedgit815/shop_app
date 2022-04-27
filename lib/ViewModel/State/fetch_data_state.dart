import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:shop_app/Model/home_model.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/ViewModel/Functions/auth_functions.dart';

class FetchDataState extends ChangeNotifier {
  final List<dynamic> dataList = [];
  bool hasMore= true;

  final Dio _dio = Dio(BaseOptions(
      baseUrl: AuthFunctions.mainUrl ,
      receiveDataWhenStatusError: true
  ));

  Future<void> fetchHomeModel({
    required String url , required int limit ,
    required int page , required BuildContext context
  }) async {
    try{

      final Response _response = await _dio.getUri(Uri.parse(url));
      final Map<String,dynamic> _map = _response.data;
      final List<dynamic> _body = _map['results'];

      if(_response.statusCode == 200){

        page++;

        if( _body.length < limit){
          hasMore = true;
        }

        notifyListeners();
        dataList.addAll(_body.map((e) => HomeModel.fromApp(e)).toList());
      }

    }on DioError catch(e){
      customSnackBar(text: 'Error in Main $e', context: context);
    }
  }


  Future<void> testHomeModel({
    required String url , required int limit ,
    required int page , required BuildContext context
  }) async {

      final http.Response _response = await http.get(Uri.parse(url));
      final Map<String,dynamic> _map = await jsonDecode(_response.body);
      final List<dynamic> _body = _map['results'];

      if(_response.statusCode == 200){
        page++;

        if( _body.length < limit){
          hasMore = true;
        }

        notifyListeners();
        dataList.addAll(_body.map((e) => HomeModel.fromApp(e)).toList());
      }
  }
}