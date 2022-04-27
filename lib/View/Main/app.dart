import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/Helper/Constance/const_functions.dart';
import 'package:shop_app/Helper/Constance/const_state.dart';
import 'package:shop_app/View/Auth/Login/main_login_screen.dart';
import 'package:shop_app/View/Main/localizations.dart';
import 'package:shop_app/View/Main/route_builder.dart';
import 'package:shop_app/View/Views/FavoriteView/main_favorite_screen.dart';
import 'package:shop_app/View/Views/HomeView/main_home_screen.dart';
import 'package:shop_app/View/Views/test.dart';


class MyApp extends ConsumerWidget {
  final Widget? screen;
  const MyApp({Key? key,this.screen}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return MaterialApp(
      title: 'Chat App' ,

      restorationScopeId: 'root' ,

      debugShowCheckedModeBanner: false ,

      themeMode: ThemeMode.light ,

      theme: ThemeData(
            primaryColor: const Color(0xff075E55) ,
            colorScheme: const ColorScheme.light().copyWith(
            primary: ConstColor.lightMainColor ,
            secondary: Colors.white ,
            brightness: Brightness.light
          ),
          iconTheme: const IconThemeData(
            color: ConstColor.normalWhite ,

          ) ,

          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xff075E55)
          )
        ) ,

     //home: const MainHomeScreen(),
     home: const MainFavoriteScreen(),

     // home: const TestPageOne() ,
      // home: screen ,

      onGenerateRoute: RouteGenerators.onGenerate ,

      locale: ConstGeneral.switchLang(ref.watch(langProv).lang),

      supportedLocales: const [
        Locale("en" , "") ,
        Locale("ar" , "") ,
        Locale("es" , "")
      ] ,

      localizationsDelegates: const [
        AppLocalization.delegate ,
        GlobalWidgetsLocalizations.delegate ,
        GlobalMaterialLocalizations.delegate ,
        GlobalCupertinoLocalizations.delegate
      ],
      localeResolutionCallback: ( currentLocal , supportedLocal ) {
        if( currentLocal != null ) {
          for( Locale loopLocal in supportedLocal ) {
            if( currentLocal.languageCode == loopLocal.languageCode ){
              return currentLocal;
            }
          }
        }
        return supportedLocal.first ;
      },
    );
  }
}