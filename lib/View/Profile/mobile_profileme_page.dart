import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/Helper/Constance/const_functions.dart';
import 'package:shop_app/Helper/Constance/const_state.dart';
import 'package:shop_app/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:shop_app/View/Main/route_builder.dart';
import 'package:shop_app/ViewModel/Functions/auth_functions.dart';


class MobileProfileMePage extends ConsumerStatefulWidget {
  const MobileProfileMePage({Key? key}) : super(key: key);

  @override
  _MobileProfileMePageState createState() => _MobileProfileMePageState();
}

class _MobileProfileMePageState extends ConsumerState<MobileProfileMePage>
with _MobileProfileMe {

  @override
  void dispose() {
    super.dispose();
    _controllerLast.dispose();
    _controllerFirst.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,

        appBar: AppBar(
        centerTitle: true ,


          leading: BackButton(
            onPressed: () async {

             // await AuthFunctions.updateImage(image: 'dasdasdasdsa', id: '62592d8af149ecda3631910d', context: context);
             // await AuthFunctions.updatePassword(newPassword: '123456', id: '6257de3f3c44f6b64ff73f97', context: context);
             // await AuthFunctions.updateName(first: 'Ali', last: 'Osman', id: '6257de3f3c44f6b64ff73f97', context: context);

             // bool _test =  await AuthFunctions.test(
             //      email: 'test@gmail.com',
             //      oldPassword: '1234567s', context: context);
             //
             // print(_test);
            },
          ),


          title: CustomText(
          text: '${context.translate!.translate(MainEnum.textProfile.name)}' ,
          fontSize: 20.0
      )),

        body: LayoutBuilder(
        builder:(context, constraints) => Consumer(
            builder: (context,prov,_)=>prov.watch(myDataProv).when(
                error: (err,stack)=>ConstGeneral.errorProvider(err) ,
                loading: ()=>ConstGeneral.loadingProvider() ,
              data: (data)=> Column(
                children:  [

                  const SizedBox(height: 15.0),


                  Stack(
                    children: [

                       CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage(data.image),
                         onBackgroundImageError: (err,stack)=>const AssetImage('assets/images/back.png'),
                      ),

                      Positioned(
                          bottom: 0,
                          left: 0.0,
                          child: CircleAvatar(
                            backgroundColor: ConstColor.lightMainColor,
                            child: IconButton(
                                onPressed: (){

                                  Navigator.of(context).pushNamed(RouteGenerators.updateImage,arguments: data);

                                  // showModalBottomSheet(context: context, builder: (context)=>SizedBox(
                                  //   height: constraints.maxHeight *0.25,
                                  //   width: double.infinity,
                                  //   child: Column(
                                  //     children: [
                                  //       Padding(
                                  //         padding: const EdgeInsets.symmetric(
                                  //             horizontal: 10.0
                                  //         ),
                                  //         child: Row(
                                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //           children: [
                                  //             const CustomText(
                                  //               text: 'Profile Picture' ,
                                  //               fontSize: 18.0,
                                  //
                                  //             ),
                                  //
                                  //             IconButton(
                                  //                 onPressed: (){},
                                  //                 icon: const Icon(Icons.delete_outline,color: ConstColor.lightMainColor))
                                  //           ],
                                  //         ),
                                  //       ),
                                  //
                                  //       Row(
                                  //         children: [
                                  //           TextButton.icon(
                                  //               onPressed: (){
                                  //                // ref.read(_prov)
                                  //               },
                                  //               icon: const Icon(Icons.camera_alt),
                                  //               label: const Text('Camera')) ,
                                  //
                                  //           TextButton.icon(
                                  //               onPressed: (){},
                                  //               icon: const Icon(Icons.image),
                                  //               label: const Text('Gallery')) ,
                                  //         ],
                                  //       )
                                  //     ],
                                  //   ),
                                  // ));
                                },
                                icon: const Icon(Icons.camera_alt,color: ConstColor.normalWhite)
                            ),
                          ))

                    ],
                  ) ,


                  const SizedBox(height: 15.0,),


                  Builder(
                      builder: (context) {
                        return _buildListTile(
                            title: '${context.translate!.translate(MainEnum.textName.name)}',
                            subTitle: data.name,
                            iconData: Icons.person ,
                            onTap: () async {

                              _controllerFirst.text = data.first;
                              _controllerLast.text = data.last;

                              return await showDialog(context: context, builder:(context)=> _buildAlertDialog(
                                  context: context,
                                  title: 'Enter your Name',
                                  onPressed: () async {
                                    // Update Name

                                     await AuthFunctions.updateName(
                                        first: _controllerFirst.text.trim(),
                                        last: _controllerLast.text.trim(),
                                        id: data.id ,
                                        context: context
                                    );

                                     ref.refresh(myDataProv);

                                     Navigator.pop(context);
                                  },
                                  name: false
                              ));
                            }
                        );
                      }
                  ),


                  Builder(
                      builder: (context) {
                        return _buildListTile(
                            title: '${context.translate!.translate(MainEnum.textPw.name)}',
                            subTitle: '${context.translate!.translate(MainEnum.textPwHere.name)}',
                            iconData: Icons.announcement_outlined ,
                            onTap: () async {
                               Navigator.of(context).pushNamed(RouteGenerators.updatePW , arguments: data );
                            });})

                ],

              )
            )
        )
            )
    );
  }


}

class _MobileProfileMe {
  final TextEditingController _controllerFirst = TextEditingController();
  final TextEditingController _controllerLast = TextEditingController();
  final GlobalKey<FormFieldState> _globalKeyPw = GlobalKey<FormFieldState>();


  ListTile _buildListTile({
    required String title , required String subTitle ,
    required IconData iconData , required VoidCallback onTap ,
  }) {
    return ListTile(
      title: CustomText(text: title ,fontSize: 15.0,fontWeight: FontWeight.w400,color: ConstColor.normalGrey.shade500),
      subtitle: CustomText(text: subTitle,
        fontSize: 16.0 ,
        fontWeight: FontWeight.w400 ,
        color: ConstColor.normalBlack ,
      ),
      leading: Icon(iconData , color: ConstColor.normalGrey.shade700) ,
      trailing: const Icon(CupertinoIcons.pencil),
      onTap: onTap,
    );
  }



  /// Build Alert Dialog
  AlertDialog _buildAlertDialog({
  required BuildContext context , required String title ,
    required VoidCallback onPressed , required bool name ,
    TextEditingController? controller ,String? hintText
}){
    return AlertDialog(
      title: Text(title),
      actions: [
        Visibility(
          visible: name ? true : false,
          child: TextFormField(
            controller: controller,
            maxLength: 30 ,
            key: _globalKeyPw ,
            validator: (v) {
              return v!.length < 3 ? 'Enter your Password' : null;
            },
            decoration: InputDecoration(
                hintText: hintText,
              //  hintText: '${context.translate!.translate(MainEnum.textPwHere.name)}',
            ),
          ),
        ),


        Visibility(
           visible: name ? false : true,
           child: TextFormField(
            controller:  _controllerFirst ,
             maxLength: 15,
             validator: (v){
               return ConstValidator.validatorName(v);
             },
            decoration: const InputDecoration(
                hintText: 'First'
            ),
        ),
         ),


        Visibility(
           visible: name ? false : true,
           child: TextFormField(
            controller:  _controllerLast ,
            maxLength: 15,
             validator: (v){
               return ConstValidator.validatorName(v);
             },
            decoration: const InputDecoration(
                hintText: 'Last',
            ),
        ),
         ),

        Row(
          children: [
            MaterialButton(
                onPressed: onPressed ,
                child: const Text('Save') ,
            ),


            MaterialButton(
              onPressed: (){
              Navigator.maybePop(context);
            },child: const Text('Close'),),
          ],
        ),
      ],
    );
  }


}