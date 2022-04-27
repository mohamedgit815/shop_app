import 'package:flutter/material.dart';
import 'package:shop_app/Helper/Constance/const_functions.dart';
import 'package:shop_app/Helper/Widgets/Customs/custom_widgets.dart';

class DefaultModalBottomSheet extends StatelessWidget {
  final String text;
  final IconData iconData;
  final VoidCallback onPressed;

  const DefaultModalBottomSheet({
    Key? key,
    required this.text,
    required this.iconData ,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [

            Icon(
              iconData,
              color: ConstColor.normalBlack,
              size: 30.0,
            ) ,

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0
                ),
                child: CustomText(
                    text: text ,
                  fontSize: 18.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
