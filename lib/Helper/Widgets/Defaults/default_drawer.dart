import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/Helper/Constance/const_state.dart';
import 'package:shop_app/Helper/Widgets/Customs/custom_widgets.dart';



class DefaultDrawer extends ConsumerStatefulWidget {
   const DefaultDrawer({Key? key}) : super(key: key);

  @override
  ConsumerState<DefaultDrawer> createState() => _DefaultDrawerState();
}


class _DefaultDrawerState extends ConsumerState<DefaultDrawer>  with _DefaultDrawerClass {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [


          Expanded(
            flex: 1,
            child: Card(
              child: InkWell(
                  onTap: (){
                    showDialog(context: context, builder: (context)=>SimpleDialog(
                      alignment: Alignment.center,
                      title: Align(
                          alignment: Alignment.center,
                          child: Text('${context.translate!.translate(MainEnum.textChooseLang.name)}')),

                      children: [

                        const Divider(thickness: 1,),

                        _buildLangButton(langName: 'Arabic', ref: ref, lang: MainEnum.arabic.name),
                        _buildLangButton(langName: 'English', ref: ref, lang: MainEnum.english.name),
                        _buildLangButton(langName: 'Español', ref: ref, lang: MainEnum.espanol.name),
                      ],
                    ));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: _langName!,
                      fontSize: 20.0,
                    ),
                  )
              ),
            ),
          ),

          Expanded(
            flex: 1,
            child: Card(
              child: InkWell(
                  onTap: (){
                   //ConstNavigator.pushNamedRouter(route: MainPostsScreen.posts, context: context);
                  },
                  child:Container(
                    margin: const EdgeInsets.all(10.0),
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: '${context.translate!.translate(MainEnum.textWrite.name)}',
                      fontSize: 20.0,
                    ),
                  )

              ),
            ),
          ),

          Expanded(
            flex: 1,
            child: Card(
              child: InkWell(
                  onTap: (){
                   // ConstNavigator.pushNamedRouter(route: MainChangePwScreen.changePw, context: context);
                  },
                  child:Container(
                    margin: const EdgeInsets.all(10.0),
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: '${context.translate!.translate(MainEnum.textChange.name)}',
                      fontSize: 20.0,
                    ),
                  )

              ),
            ),
          ),

          Expanded(
            flex: 1,
            child: Consumer(
              builder: (context,prov,_) {

                return Card(
                  child: InkWell(
                      onTap: (){
                        //  Navigator.of(context).pushNamed(MainProfileUpdateScreen.profileUpdate,arguments: _data);
                      },
                      child:Container(
                        margin: const EdgeInsets.all(10.0),
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          text: '${context.translate!.translate(MainEnum.textUpdate.name)}',
                          fontSize: 20.0,
                        ),
                      )

                  ),
                );
              }
            ),
          ),

          Expanded(
            flex: 1,
            child: Card(
              child: InkWell(
                  onTap: () async{
                   // return await AuthFunctions.signOut(context);
                  },
                  child:Container(
                    margin: const EdgeInsets.all(10.0),
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: '${context.translate!.translate(MainEnum.textLogOut.name)}',
                      fontSize: 20.0,
                    ),
                  )

              ),
            ),
          ),

          const Spacer(),
        ],
      ),
    );
  }
}


class _DefaultDrawerClass {
 // final _myData = StreamProvider((ref)=> AuthFunctions.getUserData() );
  late String? _langName = 'English';

  Widget _buildLangButton({
    required String langName ,
    required WidgetRef ref ,
    required String lang
  }) {
    return InkWell(
        onTap: (){
          ref.read(langProv).toggleLang(lang);
          _langName = langName;
        },
        child: Container(
            margin: const EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child: CustomText(text: langName,
              fontSize: 18.0,
            ))
    );
  }
}