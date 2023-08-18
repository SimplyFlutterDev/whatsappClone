import 'package:flutter/material.dart';
import 'package:whatsapp_clone/helperFiles/colorCodes/colorCodes.dart';
import 'package:whatsapp_clone/helperFiles/commonWidgets/commonWidgets.dart';

import '../authenticationScreen/authPage.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return  Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 50,left: 20,right: 20,bottom: 30),
        child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Align(child: Icon(Icons.more_vert,),alignment: Alignment.centerRight),
SizedBox(height: 20,),

Center(child: CustomAssetImage(imageWidth: screenWidth - 80,imageHeight: screenWidth - 80,fileName: "welcome_screen_vector.png",color: ColorCodes.light_green.withOpacity(0.7),),),

          SizedBox(height: 60,),

         Center(child: CustomText(text: "Welcome to WhatsApp", fontColor: Colors.black, fontSize: 22, fontWeight: FontWeight.w500),),

          SizedBox(height: 15,),

        Padding(
          padding: const EdgeInsets.only(left: 40,right: 40),
          child: RichText(
            overflow: TextOverflow.clip,
            textAlign: TextAlign.justify,
            maxLines: 3,
            text: TextSpan(
              text: 'Read our ',style: TextStyle(
              fontFamily: 'Helvetica',
              fontSize: 13,
              color: Colors.black.withOpacity(0.7),
            ),
              children:  <TextSpan>[
                const TextSpan(
                    text: 'Privacy Policy',style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 13,
                  color: ColorCodes.light_blue,
                )),
                TextSpan(
                    text: '.Tap Agree and continue to accept the ',style: TextStyle(
                  fontFamily: 'Helvetica',
                  height: 1.3,
                  fontSize: 13,
                  color: Colors.black.withOpacity(0.7),
                )),
                const TextSpan(
                    text: 'Terms of Service',style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 13,
                  color: ColorCodes.light_blue,
                )),
              ],
            ),
          ),
        ),

          SizedBox(height: 25,),

          Center(child: InkWell(onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AuthPage()));
          },
            child: Container(height: 35,width: screenWidth - 80,decoration: BoxDecoration(color: ColorCodes.teal_green_dark,
            borderRadius: BorderRadius.circular(20)),
            child: Center(child: CustomText(text: "Agree and Continue",fontWeight: FontWeight.bold,fontSize: 13,fontColor: Colors.white),),),
          )),

          SizedBox(height: 50,),

        Center(
          child: FittedBox(
               child: Container(decoration:BoxDecoration(color: Colors.grey.withOpacity(0.2),
               borderRadius: BorderRadius.circular(20)),
                 child: Padding(
                   padding: const EdgeInsets.only(top: 8,bottom: 8,left: 12,right: 12),
                   child: Row(mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                CustomAssetImage(fileName: "globe.png", imageHeight: 18, imageWidth: 18,color: ColorCodes.teal_green,),
                   SizedBox(width: 12,),
                   CustomText(text: "English",fontWeight: FontWeight.w400,fontSize: 13,fontColor: ColorCodes.teal_green),
                 SizedBox(width: 12,),
                 CustomAssetImage(fileName: "down-arrow.png", imageHeight: 18, imageWidth: 18,color: ColorCodes.teal_green,),
               ],),
                 ),),
             ),
        ),


        ],),
      ),
    );
  }
}
