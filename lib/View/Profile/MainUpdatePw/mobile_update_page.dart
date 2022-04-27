import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/Helper/Constance/const_functions.dart';
import 'package:shop_app/Helper/Constance/const_state.dart';
import 'package:shop_app/Helper/Constance/const_widgets.dart';
import 'package:shop_app/Helper/Widgets/Customs/custom_button.dart';
import 'package:shop_app/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:shop_app/Helper/Widgets/Defaults/default_textformfield.dart';
import 'package:shop_app/Helper/Widgets/Defaults/defualt_expandedauth.dart';
import 'package:shop_app/Model/user_model.dart';
import 'package:shop_app/View/Main/condtional_builder.dart';
import 'package:shop_app/ViewModel/Functions/auth_functions.dart';
import 'package:shop_app/ViewModel/State/switch_state.dart';

class MobileUpdatePage extends ConsumerStatefulWidget {
  final UserModel userModel;
  const MobileUpdatePage({Key? key,required this.userModel}) : super(key: key);

  @override
  _MobileUpdatePageState createState() => _MobileUpdatePageState();
}

class _MobileUpdatePageState extends ConsumerState<MobileUpdatePage> with _MobileUpdate {

  @override
  void dispose() {
    super.dispose();
    _controllerNewPw.dispose();
    _controllerOldPw.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
         ref.read(_checkUserProv).funcSwitchEqual(false);
         return true;
      },
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: _globalKey,
          child: Scaffold(

            appBar: AppBar(
              title:  Text('${context.translate!.translate(MainEnum.textChange.name)}'),
              centerTitle: true,
            ),

            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Consumer(
                  builder:(context,check,_)=> AnimatedConditionalBuilder(
                      condition: !check.watch(_checkUserProv).varSwitch,
                      builder: (buildContext){
                        return DefaultExpandedAuth(
                          child: Consumer(
                            builder: (context,prov,_) {
                              return DefaultTextFormField(
                                controller: _controllerOldPw,
                                validator: (String? v){
                                  return v!.length < 3 ? "Check your Password" : null;
                                },
                                password: !prov.watch(_visiblePwProv).varSwitch,
                                suffixIcon:  AnimatedConditionalBuilder(
                                  condition: prov.read(_visiblePwProv).varSwitch,
                                  builder: (BuildContext context){
                                    return ConstWidgets.iconButtonVisibility(
                                        ref: prov,
                                        color: ConstColor.normalBlack,
                                        icon: Icons.visibility,
                                        state: _visiblePwProv
                                    );
                                  },
                                  fallback: (BuildContext context){
                                    return ConstWidgets.iconButtonVisibility(
                                        ref: prov,
                                        color: ConstColor.normalBlack,
                                        icon: Icons.visibility_off,
                                        state: _visiblePwProv
                                    );
                                  },
                                ),
                                inputType: TextInputType.visiblePassword,
                                inputAction: TextInputAction.next ,
                                hint: 'Enter old Password',

                              );
                            }
                          ),
                        );
                      },
                      fallback: (buildContext){
                        return DefaultExpandedAuth(
                          child: Consumer(
                            builder: (context,prov,_) {
                              return DefaultTextFormField(
                                controller: _controllerNewPw ,
                                password: !prov.watch(_visiblePwProv).varSwitch ,
                                suffixIcon:  AnimatedConditionalBuilder(
                                  condition: prov.read(_visiblePwProv).varSwitch,
                                  builder: (BuildContext context){
                                    return ConstWidgets.iconButtonVisibility(
                                        ref: prov,
                                        color: ConstColor.normalBlack,
                                        icon: Icons.visibility,
                                        state: _visiblePwProv
                                    );
                                  },
                                  fallback: (BuildContext context){
                                    return ConstWidgets.iconButtonVisibility(
                                        ref: prov,
                                        color: ConstColor.normalBlack,
                                        icon: Icons.visibility_off,
                                        state: _visiblePwProv
                                    );
                                  },
                                ) ,
                                validator: (String? v) {
                                  return v!.length < 3 ? "Check your Password" : null;
                                },
                                inputType: TextInputType.visiblePassword,
                                inputAction: TextInputAction.next ,
                                hint: 'Enter New Password',
                              );
                            }
                          ),
                        );
                      })
                ),


                const SizedBox(height: 15.0,),


                CustomElevatedButton(
                    onPressed: () async {
                   bool _data = await AuthFunctions.checkPasswordUser(
                      email: widget.userModel.email,
                      oldPassword: _controllerOldPw.text,
                      context: context,
                     provider: _checkUserProv ,
                     widgetRef: ref
                  );

                   if(!_data) {

                     FocusScope.of(context).unfocus();
                     customSnackBar(text: 'The old Password Incorrect', context: context);

                   } else {

                     if(_controllerNewPw.text == _controllerOldPw.text){
                       FocusScope.of(context).unfocus();
                       customSnackBar(text: 'Enter different Password', context: context);

                     } else {

                       await AuthFunctions.updatePassword(
                           newPassword: _controllerNewPw.text,
                           id: widget.userModel.id,
                           context: context,
                           globalKey: _globalKey
                       );

                      // await Navigator.of(context).maybePop();
                     }

                   }

                }, child: Consumer(
                  builder: (context,prov,_) {
                    return Text(!prov.watch(_checkUserProv).varSwitch? 'Check': 'Updated');
                  }
                ))

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileUpdate {
  final _visiblePwProv = ChangeNotifierProvider<SwitchState>((ref)=>SwitchState());
  final TextEditingController _controllerOldPw = TextEditingController();
  final TextEditingController _controllerNewPw = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final _checkUserProv = ChangeNotifierProvider<SwitchState>((ref)=>SwitchState());

}

