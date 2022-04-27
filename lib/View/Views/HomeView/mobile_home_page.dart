import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/Helper/Constance/const_functions.dart';
import 'package:shop_app/Helper/Constance/const_state.dart';
import 'package:shop_app/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:shop_app/Model/home_model.dart';
import 'package:shop_app/View/Main/condtional_builder.dart';
import 'package:shop_app/View/Main/route_builder.dart';
import 'package:shop_app/ViewModel/Functions/favorite_function.dart';
import 'package:shop_app/ViewModel/State/fetch_data_state.dart';
import 'package:shop_app/ViewModel/State/switch_state.dart';

class MobileHomePage extends ConsumerStatefulWidget {
  const MobileHomePage({Key? key}) : super(key: key);

  @override
  _MobileHomePageState createState() => _MobileHomePageState();
}

class _MobileHomePageState extends ConsumerState<MobileHomePage> with _MobileHome {


  @override
  void initState() {
    super.initState();
    ref.read(_fetchHomeProv).fetchHomeModel(
        url: _url(),
        limit: _limit,
        page: _page++,
        context: context
    );

    _scrollController.addListener(() {
      if(_scrollController.position.maxScrollExtent == _scrollController.offset){
        ref.read(_fetchHomeProv).fetchHomeModel(
            url: _url(),
            limit: _limit,
            page: _page++,
            context: context
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context,i)=>[
          const SliverAppBar(
            floating: true,
            snap: true,
            centerTitle: true,
            title: Text('Home'),
          )
        ],
        body: Column(
          children: [

            Expanded(
              child: Consumer(
                builder: (buildContext,WidgetRef prov, _) {
                  return AnimatedConditionalBuilder(
                    condition: prov.watch(_fetchHomeProv).dataList.isNotEmpty,

                    builder: (buildContext) {
                        return GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                            itemCount: prov.read(_fetchHomeProv).dataList.length,
                            controller: _scrollController ,
                            itemBuilder: (BuildContext context,int i){
                              final HomeModel _data = prov.read(_fetchHomeProv).dataList.elementAt(i);
                             // final _test = StreamProvider((ref)=>FavoriteFunction.testCheckFavorite());

                              if(i < prov.read(_fetchHomeProv).dataList.length){
                                return Container(
                                  key: ValueKey<String>(_data.id),
                                  margin: const EdgeInsets.all(5.0),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage('${ConstGeneral.mainUrl}/${_data.image}')
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.of(context).pushNamed(RouteGenerators.homeDetails,arguments: _data);
                                    },
                                    child: Column(
                                      children: [
                                        const Spacer(flex: 5),

                                        Expanded(
                                          child: Container(
                                            key: ValueKey<String>(_data.id) ,
                                            width: double.infinity ,
                                            color: ConstColor.normalBlack.withOpacity(0.6) ,
                                            alignment: Alignment.center ,
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: CustomText(
                                                    key: ValueKey<String>(_data.name) ,
                                                    text: _data.name.toString() ,
                                                    color: ConstColor.normalWhite ,
                                                    fontSize: 20.0 ,
                                                  ),
                                                ),

                                                Consumer(
                                                  builder: (context,prov,_) {

                                                    return CircleAvatar(
                                                        key: ValueKey<String>(_data.id) ,
                                                        backgroundColor: prov.watch(_checkProducts).varSwitch ? Colors.red: ConstColor.lightMainColor,
                                                        child: IconButton(
                                                            key: ValueKey<String>(_data.id) ,
                                                            onPressed: () async {

                                                            }, icon: const Icon(Icons.favorite,color: ConstColor.normalWhite,)),

                                                    );
                                                  }
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return ConstGeneral.loadingProvider();
                              }
                            });
                      } ,


                    fallback: (buildContext) {
                        return Shimmer.fromColors(
                          baseColor: ConstColor.normalGrey[400]!,
                          highlightColor: ConstColor.normalGrey[300]!,
                          child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                              itemCount: 7,
                              itemBuilder: (context,i){
                                  return Container(
                                    color: ConstColor.normalGrey[400],
                                    margin: const EdgeInsets.all(5.0),
                                    width: double.infinity,
                                  );

                              }),
                        );
                      },

                  );
                }
              ),
            )

          ],
        ),
      ),
    );
  }
}

class _MobileHome{
  final int _limit = 6;
  int _page = 1;
  String _url(){
    return '${ConstGeneral.mainUrl}/products?_limit=$_limit&_page=$_page';
  }

  final _checkProducts = ChangeNotifierProvider<SwitchState>((ref)=>SwitchState());
  final _fetchHomeProv = ChangeNotifierProvider<FetchDataState>((ref)=>FetchDataState());
  final ScrollController _scrollController = ScrollController();
}