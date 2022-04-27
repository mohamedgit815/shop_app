import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/Helper/Constance/const_functions.dart';
import 'package:shop_app/Helper/Widgets/Customs/custom_button.dart';
import 'package:shop_app/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:shop_app/Model/home_model.dart';

class MobileDetailsPage extends ConsumerStatefulWidget {
  final HomeModel homeModel;

  const MobileDetailsPage({Key? key,required this.homeModel}) : super(key: key);

  @override
  _MobileDetailsPageState createState() => _MobileDetailsPageState();
}

class _MobileDetailsPageState extends ConsumerState<MobileDetailsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder:(BuildContext context,BoxConstraints constraints)=> Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('${ConstGeneral.mainUrl}/${widget.homeModel.image}') ,
                  ),
                ),
                child: Column(
                  children: [
                    const Spacer(flex: 5),

                    Expanded(
                      child: Container(
                        key: ValueKey<String>(widget.homeModel.id) ,
                        width: double.infinity ,
                        color: ConstColor.normalBlack.withOpacity(0.6) ,
                        alignment: Alignment.center ,
                        child: CustomText(
                          key: ValueKey<String>(widget.homeModel.name) ,
                          text: widget.homeModel.name.toString() ,
                          color: ConstColor.normalWhite ,
                          fontSize: 20.0 ,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ) ,

            Row(
              children: [
                Expanded(child: CustomElevatedButton(onPressed: (){}, child: const Text('Add to Cart'))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                      backgroundColor: ConstColor.lightMainColor,
                      child: IconButton(onPressed: (){}, icon: const Icon(Icons.favorite,color: ConstColor.normalWhite,))),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
