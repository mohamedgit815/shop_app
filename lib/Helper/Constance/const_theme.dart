import 'package:flutter/material.dart';
import 'package:shop_app/Helper/Constance/const_functions.dart';


final ThemeData lightTheme = ThemeData(
  /// Properties
  useMaterial3: false ,
  primaryColor: ConstColor.lightMainColor,
  unselectedWidgetColor: ConstColor.lightColorThree,
  scaffoldBackgroundColor: ConstColor.normalWhite,
  backgroundColor: ConstColor.lightMainColor,
  cardColor: ConstColor.helperColorOne,
  indicatorColor: ConstColor.normalBlack ,
  drawerTheme: DrawerThemeData(
    scrimColor: ConstColor.normalBlack.withOpacity(0.5),
  ),

  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light ,
    seedColor: const Color(0xff333333),
    primary: Colors.indigo ,
    secondary: ConstColor.lightMainColor
  ),


  /// Normal Widgets
  appBarTheme: const AppBarTheme(
      backgroundColor: ConstColor.normalBlack ,

      foregroundColor: ConstColor.normalWhite ,

      actionsIconTheme: IconThemeData(
          color: ConstColor.normalWhite,
          size: 24.0,
      ) ,

      iconTheme: IconThemeData(
          color: ConstColor.normalWhite,
          size: 20.0
      ) ,

      titleTextStyle: TextStyle(
      color: ConstColor.normalWhite,
      fontSize: 24.0,
      fontWeight: FontWeight.w400
    )
  ),
  iconTheme: const IconThemeData(
      color: ConstColor.normalBlack,
      size: 30.0
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: ConstColor.helperColorOne,
    circularTrackColor: ConstColor.lightMainColor ,
    linearTrackColor: ConstColor.lightMainColor
  ),
  dividerTheme: const DividerThemeData(
      color: ConstColor.normalBlack,
      thickness: 1.5) ,
  switchTheme: SwitchThemeData(
    trackColor: ConstGeneral.materialStateColor(ConstColor.helperColorOne),
    thumbColor: ConstGeneral.materialStateColor(ConstColor.lightMainColor),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.all(ConstColor.lightMainColor),
    checkColor: MaterialStateProperty.all(ConstColor.normalWhite),
    // overlayColor: MaterialStateProperty.all(Colors.white)
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: ConstColor.normalWhite,
    iconColor: ConstColor.normalBlack,
    suffixIconColor: ConstColor.lightColorThree,
    prefixIconColor: ConstColor.lightColorThree,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ConstColor.normalBlack),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ConstColor.lightColorThree),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ConstColor.lightColorThree),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ConstColor.lightColorThree),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ConstColor.lightColorThree),
    ),

  ) ,


  /// Alerts
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: ConstColor.normalBlack ,
    actionTextColor: ConstColor.normalWhite ,
  ) ,
  bannerTheme: const MaterialBannerThemeData(
      backgroundColor: ConstColor.normalBlack,
      contentTextStyle: TextStyle( color: ConstColor.normalWhite , fontSize: 17.0 )
  ) ,
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: ConstColor.normalWhite,
    modalBackgroundColor: ConstColor.normalWhite,
    elevation: 10.0,
    modalElevation: 10.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0),
      )
    )
  ) ,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: ConstColor.normalWhite,
      elevation: 9.0,
      selectedItemColor: ConstColor.lightMainColor ,
      unselectedItemColor: ConstColor.lightColorThree
  ),


  /// Buttons
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ConstColor.lightMainColor ,
      foregroundColor: ConstColor.normalWhite
    ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: ConstColor.normalBlack,
      primary: ConstColor.normalWhite,
    )
  ) ,
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          primary: ConstColor.normalBlack ,
          backgroundColor: ConstColor.normalWhite ,
          textStyle: const TextStyle(fontSize: 17.0,) ,
          side: const BorderSide(color: ConstColor.helperColorOne)
      ),

      ) ,
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        onPrimary: ConstColor.normalWhite ,
        primary: ConstColor.lightMainColor,
        textStyle: const TextStyle(fontSize: 15.0),
      )
  ) ,
);

final ThemeData darkTheme = ThemeData(
  /// Properties
  primaryColor: ConstColor.darkMainColor ,
  scaffoldBackgroundColor: ConstColor.darkColorTow ,
  backgroundColor: ConstColor.darkColorOne ,
  indicatorColor: ConstColor.darkColorTow ,
  cardColor: ConstColor.darkColorOne ,
  colorScheme: const ColorScheme.dark().copyWith(
    brightness: Brightness.dark ,
    primary: ConstColor.darkMainColor ,
    secondary: ConstColor.normalWhite
  ) ,


  /// Normal Widgets
  appBarTheme: const AppBarTheme(
      backgroundColor: ConstColor.darkColorOne ,
      foregroundColor: ConstColor.normalWhite ,
      actionsIconTheme: IconThemeData(
          color: ConstColor.normalWhite ,
          size: 25.0
      ),
      iconTheme: IconThemeData(
          color: ConstColor.normalWhite ,
          size: 25.0
      )
  ) ,
  iconTheme: const IconThemeData(
      color: ConstColor.normalWhite,
      size: 20.0
  ) ,
  dividerTheme: const DividerThemeData(
      color: ConstColor.helperColorOne,
      thickness: 1.5) ,
  switchTheme: SwitchThemeData(
    trackColor: ConstGeneral.materialStateColor(ConstColor.normalBlack),
    thumbColor: ConstGeneral.materialStateColor(ConstColor.darkMainColor),
  ) ,
  checkboxTheme: CheckboxThemeData(
    fillColor: ConstGeneral.materialStateColor(ConstColor.darkMainColor),
    checkColor: ConstGeneral.materialStateColor(ConstColor.normalWhite),
    //  overlayColor: MaterialStateProperty.all(Colors.white)
  ) ,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: ConstColor.helperColorOne,
      circularTrackColor: ConstColor.darkMainColor,
      linearTrackColor: ConstColor.darkMainColor,
      refreshBackgroundColor: ConstColor.helperColorOne
  ) ,
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: ConstColor.darkColorOne,
    iconColor: ConstColor.normalWhite,
    suffixIconColor: ConstColor.normalWhite,
    prefixIconColor: ConstColor.normalWhite,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ConstColor.normalWhite),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ConstColor.normalWhite),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ConstColor.normalWhite),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ConstColor.normalWhite),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ConstColor.normalWhite),
    ),

  ) ,


  /// Alerts
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: ConstColor.normalWhite ,
    actionTextColor: ConstColor.darkMainColor ,
  ) ,
  bannerTheme: const MaterialBannerThemeData(
      backgroundColor: ConstColor.darkColorOne,
      contentTextStyle: TextStyle(color: ConstColor.normalWhite , fontSize: 17.0)
  ) ,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: ConstColor.darkColorOne,
      selectedItemColor: ConstColor.darkMainColor ,
      unselectedItemColor: ConstColor.normalWhite
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: ConstColor.darkColorOne ,
    modalBackgroundColor: ConstColor.darkColorOne ,
    elevation: 9.0
  ),


  /// Buttons
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: ConstColor.darkMainColor,
    foregroundColor: ConstColor.normalWhite,
    // splashColor: Colors.red,
  ) ,
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: ConstColor.normalWhite,
        backgroundColor: ConstColor.darkMainColor,
        textStyle: const TextStyle(fontSize: 15.0),
      )
  ) ,
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom (
        primary: ConstColor.normalWhite,
          backgroundColor: ConstColor.darkMainColor,
          textStyle: const TextStyle(fontSize: 15.0),
          side: const BorderSide(color: ConstColor.normalWhite,style: BorderStyle.solid)
      )
  ) ,
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        onPrimary: ConstColor.normalWhite,
        textStyle: const TextStyle(fontSize: 15.0)),
      )
);