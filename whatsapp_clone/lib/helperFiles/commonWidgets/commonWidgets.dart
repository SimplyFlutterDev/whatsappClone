
import 'package:flutter/material.dart';

import '../colorCodes/colorCodes.dart';

class CustomAssetImage extends StatelessWidget {

  String fileName;
  double imageHeight;
  double imageWidth;
  Color? color;

   CustomAssetImage({Key? key,this.color,required this.fileName,required this.imageHeight,required this.imageWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Image.asset("assets/images/${fileName}",height: imageHeight,width: imageWidth,color: color,);
  }
}

class CustomText extends StatelessWidget {
  String text;
  double fontSize;
  Color fontColor;
  FontWeight fontWeight;
   CustomText({Key? key,required this.text,required this.fontColor,required this.fontSize,required this.fontWeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Helvetica',
        fontSize: fontSize,
        color: fontColor,
        fontWeight: fontWeight,
      ),
    );
  }
}


class CustomButton extends StatelessWidget {
  String title;
   CustomButton({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  FittedBox(
      child: Container(padding:EdgeInsets.only(left: 20,right: 20),height: 35,decoration: BoxDecoration(color: ColorCodes.teal_green_dark,
          borderRadius: BorderRadius.circular(20)),
        child: Center(child: CustomText(text: title,fontWeight: FontWeight.bold,fontSize: 13,fontColor: Colors.white),),),
    );
  }
}


