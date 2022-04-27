import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/Helper/Constance/const_functions.dart';
import 'package:shop_app/Helper/Widgets/Customs/custom_button.dart';
import 'package:shop_app/Model/user_model.dart';
import 'package:shop_app/ViewModel/Functions/auth_functions.dart';
import 'package:shop_app/ViewModel/State/image_state.dart';

class MobileUpdateImagePage extends ConsumerStatefulWidget {
  final UserModel userModel ;

  const MobileUpdateImagePage({Key? key,required this.userModel}) : super(key: key);

  @override
  _MobileUpdateImagePageState createState() => _MobileUpdateImagePageState();
}

class _MobileUpdateImagePageState extends ConsumerState<MobileUpdateImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Visibility(
            visible: ref.read(_imageProfileProv).fileImage != null ? false : true,
            child: Expanded(
              flex: 1,
              child: Center(
                child: Wrap(
                  spacing: 10.0,
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [

                    CustomElevatedIconButton(onPressed: (){
                      ref.read(_imageProfileProv).getImagePicker(
                          context: context, imageSource: ImageSource.camera);
                    }, child: const Text('Camera'), icon: const Icon(Icons.image)),


                    CustomElevatedIconButton(onPressed: (){
                      ref.read(_imageProfileProv).getImagePicker(
                          context: context, imageSource: ImageSource.gallery);
                    }, child: const Text('Gallery'), icon: const Icon(Icons.image)),
                    // CustomElevatedIconButton(onPressed: (){}, child: const Text('Remover'), icon: const Icon(Icons.close)),
                  ],
                ),
              ),
            ),
          ) ,


          Consumer(
              builder: (buildContext,prov,_) {
                return Visibility(
                  visible: ref.watch(_imageProfileProv).fileImage == null ? false :true,
                  child: Expanded(
                      flex: 7,
                      child: Builder(
                          builder: (context) {
                            return Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: prov.watch(_imageProfileProv).fileImage != null ?
                                      FileImage(prov.watch(_imageProfileProv).fileImage!) : null as ImageProvider
                                  )
                              ),
                              alignment: Alignment.bottomCenter,
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: ConstColor.lightMainColor,
                                    child: IconButton(
                                      icon: const Icon(Icons.close,color: ConstColor.normalWhite,),
                                      onPressed: () {
                                        prov.read(_imageProfileProv).deleteImagePicker();
                                      },
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 25.0,
                                    backgroundColor: ConstColor.lightMainColor,
                                    child: IconButton(
                                      icon: const Icon(Icons.cloud_upload,color: ConstColor.normalWhite,),
                                      onPressed: () async {

                                        await AuthFunctions.updateImage(id: widget.userModel.id, context: context,file: prov.read(_imageProfileProv).fileImage!);

                                        ref.read(_imageProfileProv).deleteImagePicker();

                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                      )
                  ),
                );
              }
          )
        ],
      )
    );
  }
}

final _imageProfileProv = ChangeNotifierProvider<ImageState>((ref)=>ImageState());


