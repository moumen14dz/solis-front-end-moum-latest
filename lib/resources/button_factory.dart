
import 'package:flutter/material.dart';


class ButtonFactory {
  Widget createImageTextBtn(
      {required String icon,
        required String title,
        required Color titleColor,
        required BuildContext context,
        required Color boarderColor,
        required Color backgroundColor,
        required double boarderThickness,
        required double textSize,
        required VoidCallback onButtonPressed}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: boarderColor, width: boarderThickness),
        borderRadius: BorderRadius.circular(35),
      ),
      //margin: const EdgeInsets.only(top: 25),
      child: Material(
        color: backgroundColor,
        elevation: 1.0,
        borderRadius: BorderRadius.circular(35),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          splashColor: Colors.grey,
          onTap: onButtonPressed,
          child: Container(
            margin: const EdgeInsets.only(top: 15, bottom: 15),
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  icon,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: textSize, color: titleColor,
                        fontFamily: 'SF-Pro'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget showTextBtn( {
    required String title,
    required Color titleColor,
    required BuildContext context,
    required Color boarderColor,
    required Color backgroundColor,
    required double boarderThickness,
    required double textSize,
    required bool isEnabled,
    required VoidCallback onButtonPressed}) {

    debugPrint("Is that $isEnabled");
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: boarderColor),
        //border: Border.all(color: isEnabled ? boarderColor : Colors.white, width: boarderThickness),
        borderRadius: BorderRadius.circular(35),
      ),
      child: Material(
        color: backgroundColor,
        //color: isEnabled ? backgroundColor : Colors.white,
        elevation: 4.0,
        borderRadius: BorderRadius.circular(35),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: isEnabled ? onButtonPressed : null,
          child: Container(
            margin: const EdgeInsets.only(top: 15, bottom: 15),
            alignment: Alignment.center,
            child: Text(title,
                style: TextStyle(fontSize: textSize, color: titleColor,
                    fontFamily: 'SF-Pro')),
          ),
        ),
      ),
    );
  }

}