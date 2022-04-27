import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/View/Main/condtional_builder.dart';


class TestPageOne extends ConsumerStatefulWidget {
  const TestPageOne({Key? key}) : super(key: key);

  @override
  ConsumerState<TestPageOne> createState() => _TestPageOneState();
}

class _TestPageOneState extends ConsumerState<TestPageOne> with _TestClass{
  late final ChangeNotifierProvider<_TestProvider> _fetchDataProv  = ChangeNotifierProvider<_TestProvider>((ref)=>_TestProvider());
  final ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      ref.read(_fetchDataProv).fetchDataProv(
          url: _funcUrl(), page: _page++, limit: _limit);

    });

    //fetch();
    _scrollController.addListener(() {
      if(_scrollController.position.maxScrollExtent == _scrollController.offset){
        ref.read(_fetchDataProv).fetchDataProv(
          url: _funcUrl() , page: _page++, limit: _limit);
      }});
  }

  @override
  Widget build(BuildContext context) {
   // print(mainData);

    return Scaffold(
      appBar: AppBar(title: const Text('TestOne'),),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add,color: Colors.white,),
        onPressed: (){
          _scrollController.jumpTo(0);
        },
      ),
      body: Column(
        children: [

          Expanded(
              child: Consumer(
                builder: (context,  WidgetRef prov,_) {
                  return AnimatedConditionalBuilder(
                    condition: prov.watch(_fetchDataProv).dataList.isNotEmpty,
                    builder: (context) {
                      return ListView.separated(
                          controller: _scrollController ,
                          separatorBuilder: (context,i)=>const Divider(thickness: 1,),
                          itemCount: prov.read(_fetchDataProv).dataList.length ,
                          itemBuilder: (context,i) {

                            final _FetchData _data = prov.watch(_fetchDataProv).dataList.elementAt(i);
                            if(i < prov.read(_fetchDataProv).dataList.length){
                              return ListTile(
                                  key: ValueKey<int>(_data.id),
                                  title: Text(_data.id.toString()) ,
                                  subtitle: Text(_data.body)
                              );
                            } else {
                              return Center(
                                  child: CircularProgressIndicator.adaptive(
                                    key: ValueKey<int>(_data.id),
                                  ));
                            }

                      }
                      );
                    } ,
                    fallback: (buildContext)=>const Center(child: CircularProgressIndicator.adaptive()),
                  );
                }
              ))

        ],
      ),
    );
  }



}

class _TestClass {
  int _page = 1;
  final int _limit = 25;
  String _funcUrl(){
    return 'https://jsonplaceholder.typicode.com/posts?_limit=$_limit&_page=$_page';
  }

}

class _FetchData {
  final String title, body;
  final int id;
  const _FetchData({required this.body,required this.title,required this.id});


  factory _FetchData.fromApp(Map<String,dynamic>map){
    return _FetchData(
        body: map['body'] ,
        title: map['title'] ,
        id: map['id']
    );
  }


  static Future<List<_FetchData>> fetchData(int page) async {
    const int _limit = 24;
    //const int _page = 2;
    final http.Response _response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=$_limit&_page=$page'));

    final List<dynamic> _body = jsonDecode(_response.body);

    if(_response.statusCode == 200){
      final List<_FetchData> _data = _body.map((e) => _FetchData.fromApp(e)).toList();
      return _data;
    } else {
      throw Exception('Check Data');
    }
  }
}

class _TestProvider extends ChangeNotifier {
  final List<_FetchData> dataList = [];
  bool hasMore = true;


  Future<void> fetchDataProv({
    required String url ,required int page ,
    required int limit ,
  }) async {
    final http.Response _response = await http.get(Uri.parse(url));

    final List<dynamic> _body = jsonDecode(_response.body);

    if(_response.statusCode == 200) {

        page++;

        if(_body.length < limit){
          hasMore = false;
        }

        notifyListeners();
        return dataList.addAll(_body.map((e) => _FetchData.fromApp(e)).toList());
    }
  }
}