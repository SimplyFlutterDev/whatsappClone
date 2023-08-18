import 'package:flutter/material.dart';
import 'package:whatsapp_clone/helperFiles/colorCodes/colorCodes.dart';
import 'package:whatsapp_clone/helperFiles/commonWidgets/commonWidgets.dart';
import 'package:whatsapp_clone/uiScreens/homepage/homepage.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50,left: 30,right: 30),
        child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
        children: [
Center(child: CustomText(text: "Enter your phone number", fontColor: ColorCodes.teal_green_dark, fontSize: 18, fontWeight: FontWeight.bold)),

          SizedBox(height: 30,),
          Center(child: RichText(  overflow: TextOverflow.clip,
              textAlign: TextAlign.center  ,
              maxLines: 3,
              text: const TextSpan(
                  text: 'WhatsApp will need to verify your account ',style: TextStyle(
                fontFamily: 'Helvetica',
                fontSize: 13,
                color: Colors.black,
              ),
                  children:  <TextSpan>[
               TextSpan(
              text: "What's my number ?",style: TextStyle(
                fontFamily: 'Helvetica',
                fontSize: 13,
                color: ColorCodes.light_blue,
              )),
        ],),
      ),
    ),
          SizedBox(height: 20,),

        Container(margin:const EdgeInsets.only(left: 20,right: 20),child: const TextField(textAlign: TextAlign.center,
          decoration:  InputDecoration(
          hintText: "Choose a country",
          hintStyle: TextStyle(
            fontFamily: 'Helvetica',
            fontSize: 15,
            color: Colors.black,
          ),
          enabled: false,
          suffixIcon: Icon(Icons.arrow_drop_down,color: ColorCodes.teal_green,),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorCodes.teal_green),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorCodes.teal_green),
          ),
            disabledBorder:  UnderlineInputBorder(
              borderSide: BorderSide(color: ColorCodes.teal_green)),
        ),),),

          SizedBox(height: 5,),


          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Row(mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                const SizedBox(width:60,child: Expanded(
                  child: TextField(decoration:  InputDecoration(
                    hintText: "+      91",
                    hintStyle: TextStyle(
                      fontFamily: 'Helvetica',
                      fontSize: 15,
                      color: Colors.black,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorCodes.teal_green),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorCodes.teal_green),
                    ),
                  ),),
                ),),

                SizedBox(width: 15,),

                Expanded(
                  child: TextField(decoration:  InputDecoration(
                    hintText: "phone number",
                    hintStyle: TextStyle(
                      fontFamily: 'Helvetica',
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.6),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorCodes.teal_green),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorCodes.teal_green),
                    ),
                  ),),
                ),
              ],
            ),

          ),

          SizedBox(height: 20,),

          CustomText(fontSize: 13,fontColor: Colors.black.withOpacity(0.6),fontWeight: FontWeight.w500,text: "Carrier charges may apply",),
          
          Spacer(),

          InkWell(onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
          },
            child: FittedBox(
              child: Container(padding:EdgeInsets.only(left: 20,right: 20),height: 35,decoration: BoxDecoration(color: ColorCodes.teal_green_dark,
                  borderRadius: BorderRadius.circular(20)),
                child: Center(child: CustomText(text: "Next",fontWeight: FontWeight.bold,fontSize: 13,fontColor: Colors.white),),),
            ),
          ),
          
          SizedBox(height: 40,)

        ])));
  }
}
