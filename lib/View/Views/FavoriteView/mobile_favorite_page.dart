import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/Helper/Constance/const_functions.dart';
import 'package:shop_app/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:shop_app/Model/favorite_model.dart';
import 'package:shop_app/View/Main/condtional_builder.dart';
import 'package:shop_app/ViewModel/Functions/favorite_function.dart';

class MobileFavoritePage extends ConsumerStatefulWidget {
  const MobileFavoritePage({Key? key}) : super(key: key);

  @override
  _MobileCartPageState createState() => _MobileCartPageState();
}

class _MobileCartPageState extends ConsumerState<MobileFavoritePage> with MixinMobileFavorite {
  @override
  Widget build(BuildContext context) {
    final _fetchFavoriteProv = StreamProvider((ref)=>FavoriteFunction.fetchFavorite(idUser: '6259404ef149ecda3631962b'));


    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstColor.normalWhite,
        centerTitle: true,
        title: const CustomText(
          text: 'Favorite',
          fontSize: 20.0,
          color: ConstColor.normalBlack,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: LayoutBuilder(
        builder:(context, constraints) => Column(
          children: [

            Expanded(
                child: Consumer(
                  builder: (context,prov,_) {
                    return prov.watch(_fetchFavoriteProv).when(
                        error: (err,stack)=> ConstGeneral.errorProvider(err),
                        loading: ()=> ConstGeneral.loadingProvider() ,
                      data: (data) {
                        final List<dynamic> _data = data.data['data'];

                        return ListView.separated(
                          separatorBuilder: (context,i)=> const Divider(thickness: 1,),
                          itemCount: _data.length,
                          itemBuilder: (context,i) {

                            return ListTile(
                            title: CustomText(text: _data.elementAt(i)['name']),
                            //subtitle:  CustomText(text: _data.elementAt(i)['image']),
                            leading: CircleAvatar(
                                backgroundImage: NetworkImage('${ConstGeneral.mainUrl}/${_data.elementAt(i)['image']}'),
                            ),
                            trailing: IconButton(onPressed: (){}, icon: const Icon(Icons.delete,color: Colors.red,)),
                          );
                          }
                      );
                      }
                    );
                  }
                ))

          ],
        ),
      ),
    );
  }


}


class MixinMobileFavorite {

}