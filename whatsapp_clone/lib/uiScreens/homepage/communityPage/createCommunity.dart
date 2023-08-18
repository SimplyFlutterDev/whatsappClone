import 'package:flutter/material.dart';

import '../../../helperFiles/colorCodes/colorCodes.dart';
import '../../../helperFiles/commonWidgets/commonWidgets.dart';

class CreateCommunity extends StatefulWidget {
  const CreateCommunity({Key? key}) : super(key: key);

  @override
  State<CreateCommunity> createState() => _CreateCommunityState();
}

class _CreateCommunityState extends State<CreateCommunity> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor: Colors.white,
    body: Padding(
      padding: const EdgeInsets.only(top: 60,left: 20,right: 20,bottom: 30),
      child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Align(child: InkWell(onTap:(){
          Navigator.pop(context);
        },child: Icon(Icons.close)),alignment: Alignment.topLeft),

        CustomAssetImage(fileName: "create_community_vector.jpeg", imageHeight: 250, imageWidth: 250),
        SizedBox(height: 30,),
        Center(child: CustomText(text: "Create a new community", fontColor: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),

        // Center(child: CustomText(text: "Bring together a neighbourhood, school or more.Create topic-based groups for members,easily send them admin announcements.", fontColor: Colors.black.withOpacity(0.4), fontSize: 13, fontWeight: FontWeight.w400))

        SizedBox(height: 8,),
        Text(
          textAlign: TextAlign.center,
          "Bring together a neighbourhood, school or more.Create topic-based groups for members,easily send them admin announcements.",
          style: TextStyle(
            fontFamily: 'Helvetica',
            fontSize: 18,
            height: 1.3,
            color: Colors.black.withOpacity(0.5),
            fontWeight: FontWeight.w500,
          ),
        ),


        Spacer(),


        Container(height: 40,width: MediaQuery.of(context).size.width - 80,decoration: BoxDecoration(color: ColorCodes.teal_green_dark,
            borderRadius: BorderRadius.circular(20)),
          child: Center(child: CustomText(text: "Get started",fontWeight: FontWeight.bold,fontSize: 15,fontColor: Colors.white),),),
      ],),
    ),);
  }
}
