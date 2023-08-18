import 'package:flutter/material.dart';
import 'package:whatsapp_clone/helperFiles/commonWidgets/commonWidgets.dart';

import '../../../helperFiles/colorCodes/colorCodes.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {

    Widget addStatus(){
      return Container(child: Row(mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(children:[ CircleAvatar(backgroundImage: const AssetImage("assets/images/man_placeholder.png"),radius: 27 ,backgroundColor: Colors.white),

        Positioned(child: Container(height: 22,width: 22,decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 2),borderRadius:BorderRadius.circular(50),color: ColorCodes.teal_green),
        child: Center(child: Icon(Icons.add,color: Colors.white,size: 18,),),),
        bottom: 0,right: 0,)
        ]),
        SizedBox(width: 15,),
        Column(mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          CustomText(text: "My Status", fontColor: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          SizedBox(height: 5,),
          CustomText(text: "Tap to add status update", fontColor: Colors.grey.withOpacity(0.9), fontSize: 13, fontWeight: FontWeight.w500),
        ],)
      ],),);
    }

    Widget recentUpdates(){
      return ListView.builder(shrinkWrap: true,
          itemCount: 8,
          physics: ScrollPhysics(),
          itemBuilder: (context,index){
        return Container(margin:EdgeInsets.only(bottom: 18),child: Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(height: 50,width: 50,decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.grey),),
            Container(decoration:BoxDecoration(borderRadius: BorderRadius.circular(50),
            border: Border.all(color: ColorCodes.light_green,width: 1.5)),child: CircleAvatar(backgroundImage: const AssetImage("assets/images/man_placeholder.png"),radius: 26 ,backgroundColor: Colors.white)),
            SizedBox(width: 15,),
            Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5,),
                CustomText(text: "Flutter Friend", fontColor: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                SizedBox(height: 8,),
                CustomText(text: "36 minutes ago", fontColor: Colors.black.withOpacity(0.5), fontSize: 13, fontWeight: FontWeight.w400),
              ],),
          ],),);
      });
    }

    return  Scaffold(
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
          child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            addStatus(),
            SizedBox(height: 20,),
            CustomText(text: "Recent updates", fontColor: Colors.grey.withOpacity(0.9), fontSize: 14, fontWeight: FontWeight.bold),
            SizedBox(height: 20,),
            recentUpdates()

          ],),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))
      ),
        child: Icon(Icons.camera_alt),
        backgroundColor: ColorCodes.teal_green,
        onPressed: () {
        },
      ),
    );
  }
}
