import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/Helper/Constance/const_functions.dart';
import 'package:shop_app/ViewModel/State/switch_state.dart';

class ConstWidgets {
  static IconButton iconButtonVisibility({
    required WidgetRef ref ,
    required IconData icon ,
    required ChangeNotifierProvider<SwitchState> state ,
    VoidCallback? onPressed ,
    Color? color ,
  }){
    return IconButton(
        onPressed: onPressed ?? (){
          ref.read(state).funcSwitch();
        },
        icon: Icon(icon,color: color ?? ConstColor.normalWhite ));
  }
}