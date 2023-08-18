import 'package:flutter/material.dart';
import 'package:whatsapp_clone/helperFiles/commonWidgets/commonWidgets.dart';
import 'package:whatsapp_clone/uiScreens/homepage/communityPage/createCommunity.dart';

import '../../../helperFiles/colorCodes/colorCodes.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor: Colors.white,
      body: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        SizedBox(height: 30,),
        Center(child: CustomAssetImage(fileName: "community_vector.jpeg", imageHeight: 200, imageWidth: MediaQuery.of(context).size.width - 60)),

        SizedBox(height: 30,),

        Center(child: CustomText(text: "Stay connected with a community", fontColor: Colors.black, fontSize: 17, fontWeight: FontWeight.w600)),


      Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
        child: Text(textAlign: TextAlign.center,
          "Communities bring members together ing topic - based groups, and make it easy to get admin announcements.Any Community you're added to will appear here.",
          style: TextStyle(
            fontFamily: 'Helvetica',
            height: 1.3,
            fontSize: 13,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),

        Spacer(),

        InkWell(onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateCommunity()));
        },
          child: Container(height: 40,width: MediaQuery.of(context).size.width - 80,decoration: BoxDecoration(color: ColorCodes.teal_green_dark,
              borderRadius: BorderRadius.circular(20)),
            child: Center(child: CustomText(text: "Start your community",fontWeight: FontWeight.bold,fontSize: 13,fontColor: Colors.white),),),
        ),


        SizedBox(height: 50,)
      ],),
    );
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog( // <-- SEE HERE
          content: SingleChildScrollView(
            child: Container(
              child: ListBody(
                children:  <Widget>[
CustomAssetImage(fileName: "create_community_vector.jpeg", imageHeight: 200, imageWidth: 250),
                  SizedBox(height: 30,),
                  Center(child: CustomText(text: "Create a new community", fontColor: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),

                  // Center(child: CustomText(text: "Bring together a neighbourhood, school or more.Create topic-based groups for members,easily send them admin announcements.", fontColor: Colors.black.withOpacity(0.4), fontSize: 13, fontWeight: FontWeight.w400))

                  SizedBox(height: 8,),
                  Text(
                    textAlign: TextAlign.center,
                    "Bring together a neighbourhood, school or more.Create topic-based groups for members,easily send them admin announcements.",
                    style: TextStyle(
                      fontFamily: 'Helvetica',
                      fontSize: 15,
                      height: 1.3,
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w500,
                    ),
                  ),


                  SizedBox(height: 70,),


                  Container(height: 40,width: MediaQuery.of(context).size.width - 80,decoration: BoxDecoration(color: ColorCodes.teal_green_dark,
                      borderRadius: BorderRadius.circular(20)),
                    child: Center(child: CustomText(text: "Get started",fontWeight: FontWeight.bold,fontSize: 13,fontColor: Colors.white),),),
                ],
              ),
            ),
          ),
          actions: <Widget>[

          ],
        );
      },
    );
  }
}
